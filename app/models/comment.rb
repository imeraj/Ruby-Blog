class Comment < ApplicationRecord
  include Swagger::Blocks

  swagger_schema :Comment do
    key :required, [:id, :commenter, :body, :article_id]
    property :id do
      key :type, :integer
    end
    property :commenter do
      key :type, :string
    end
    property :body do
      key :type, :text
    end
    property :article_id do
      key :type, :integer
    end
  end

  belongs_to :article
end
