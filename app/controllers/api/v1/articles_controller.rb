module Api
    module V1
        class ArticlesController < ApplicationController
            include Swagger::Blocks

            swagger_path '/articles/:id' do
                operation :get do
                    key :description, 'returns a single article'
                    key :tags, [
                        'articles'
                    ]
                    parameter do
                        key :name, :id
                        key :in, :path
                        key :description, 'ID of article to fetch'
                        key :required, true
                        key :type, :integer
                    end
                    response 200 do
                        key :description, 'article response'
                        schema do
                            key :type, :object
                            key :required, [:name, :article]
                            property :success do
                                key :type, :boolean
                            end
                            property :article do
                                key :type, :object
                                key :required, [:id, :title, :text]
                                property :id do
                                    key :type, :integer
                                end
                                property :title do
                                    key :type, :text
                                end
                                property :text do
                                    key :type, :text
                                end
                                property :comments do
                                    key :type, :object
                                    key :required, [:id, :commenter, :body]
                                    property :id do
                                        key :type, :integer
                                    end
                                    property :commenter do
                                        key :type, :string
                                    end
                                    property :body do
                                        key :type, :text
                                    end
                                end
                            end
                        end
                    end
                end
            end


            http_basic_authenticate_with name: "meraj", password: "secret", except: [:index, :show]

            def new
                @article = Article.new
            end

            def edit
                @article = Article.find(params[:id])
            end

            def show
                @article = Article.find(params[:id])

                respond_to do |format|
                    format.json { render :json => {
                        :success => true,
                        :article => @article.to_json(:only => [:id, :title, :text], :include => {
                            :comments => {:only => [:id, :commenter, :body]}
                        })
                    }
                    }
                    format.html
                end
            end

            def create
                @article = Article.new(article_params)

                if @article.save
                    redirect_to @article
                else
                    render 'new'
                end
            end

            def update
                @article = Article.find(params[:id])

                if @article.update(article_params)
                    redirect_to @article
                else
                    render 'edit'
                end
            end

            def index
                @articles = Article.all

                respond_to do |format|
                    format.json { render :json => {
                        :success => true,
                        :articles => @articles.to_json(:only => [:id, :title, :text])
                    }
                    }
                    format.html
                end
            end

            def destroy
                @article = Article.find(params[:id])
                @article.destroy

                redirect_to articles_path
            end

            private
            def article_params
                params.require(:article).permit(:title, :text)
            end
        end
    end
end