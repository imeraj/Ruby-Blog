class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :dump_request
  before_action :dump_parameters

  after_action :dump_response

  private
  def dump_request
    p @_request
  end

  def dump_parameters
    p @_params
  end

  def dump_response
    p @_response.headers
    p @_response_body
  end
end
