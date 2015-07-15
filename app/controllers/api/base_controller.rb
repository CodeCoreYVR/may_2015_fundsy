class Api::BaseController < ApplicationController
  before_action :authorize

  private

  def authorize
    @user = User.find_by_api_key(params[:api_key])
    head :unauthorized unless @user
  end
end
