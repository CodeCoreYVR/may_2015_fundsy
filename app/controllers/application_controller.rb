class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user
    @current_user ||= User.find_by_id session[:user_id]
  end

  def authenticate_user!
    redirect_to new_session_path unless user_signed_in?
  end

  def user_signed_in?
    current_user.present?
  end
end
