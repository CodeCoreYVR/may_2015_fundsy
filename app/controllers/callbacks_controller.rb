class CallbacksController < ApplicationController
  def index
    omniauth_data = env["omniauth.auth"]
    user          = User.where(provider: omniauth_data["provider"],
                               uid:      omniauth_data["uid"]).first
    if user.nil?
      service = Users::CreateFromOmniauth.new(omniauth_data: omniauth_data)
      service.call
      user    = service.user
    end
    session[:user_id] = user.id
    redirect_to root_path, notice: "Thank you for signing in with #{omniauth_data["provider"]}"
    # render json: env["omniauth.auth"].to_json
  end
end
