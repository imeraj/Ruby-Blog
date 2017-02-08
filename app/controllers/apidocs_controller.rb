class ApidocsController < ApplicationController
  include Swagger::Blocks

  swagger_root do
    key :swagger, '2.0'
    info do
      key :version, '1.0.0'
      key :title, 'Swagger Blog'
      contact do
        key :name, 'Meraj'
        key :email, 'meraj.enigma@gmail.com'
      end
      license do
        key :name, 'MIT'
      end
    end
    tag do
      key :name, 'Blog'
      key :description, 'Blog operations'
    end
    key :basePath, '/'
    key :consumes, ['application/json']
    key :produces, ['application/json']
  end

  SWAGGERED_CLASSES = [
      Api::V1::ArticlesController,
      Api::V2::ArticlesController,
      self,
  ].freeze

  def index
    swagger_data = Swagger::Blocks.build_root_json(SWAGGERED_CLASSES)
    File.open('swagger.json', 'w') { |file| file.write(swagger_data.to_json) }

    render json: swagger_data
  end
end
