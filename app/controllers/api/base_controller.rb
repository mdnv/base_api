class Api::BaseController < ApplicationController
  respond_to :json

  def ensure_params_exist
    return if params[:user].present?
    render json: {status: "false", message: "Missing params"}, status: 422
  end

  def load_user_authentication
    @user = User.find_by_email user_params[:email]
    login_invalid unless @user
  end

  def login_invalid
    render json: {status: "false", message: "Email not found"}, status: 404
  end

  def find_current_user
    @current_user ||= User.find_by authentication_token: request.headers["Authorization"]
  end

  private

  def authenticate_user_from_token
    find_current_user

    render json: {status: "false", message: "You are not authenticated"}, status: 401 if @current_user.nil?
  end
end
