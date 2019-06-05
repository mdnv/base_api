class Api::BaseController < ApplicationController
  respond_to :json

  def load_user_authentication
    @user = User.find_by_email user_params[:email]
    render json: {status: "false", message: "Email not found"}, status: 404 unless @user
  end

  def authenticate_user_from_token
    @current_user ||= User.find_by authentication_token: request.headers["Authorization"]

    render json: {status: "false", message: "You are not authenticated"}, status: 401 unless @current_user
  end
end
