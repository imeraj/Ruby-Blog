class Article < ApplicationRecord
    include Swagger::Blocks

    swagger_schema :Article do
        key :required, [:id, :title, :text]
        property :id do
            key :type, :integer
        end
        property :title do
            key :type, :string
        end
        property :text do
            key :type, :text
        end
    end

    has_many :comments, dependent: :destroy
    validates :title, presence: true,
                    length: { minimum: 5 }
    validates :text, presence: true
end