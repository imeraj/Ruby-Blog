
    module V1
        class ArticlesController < ApplicationController
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
