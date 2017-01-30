class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :dump_params
  after_action :dump_response

  private
  def dump_params
    p params
  end

  def dump_response
    p @_response.headers
    p @_response_body
  end

end
