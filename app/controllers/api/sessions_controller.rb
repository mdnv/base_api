class Api::SessionsController < Api::BaseController
  before_action :ensure_params_exist, only: :create
  before_action :load_user_authentication, only: :create
  before_action :authenticate_user_from_token, only: :destroy

  respond_to :json

  def create
    if @user.valid_password? user_params[:password]
      sign_in @user, store: false
      @user.update(
          authentication_token: Devise.friendly_token,
          authentication_token_created_at: Time.now
      )

      render json: {status: "true", message: "Signed in successfully", user: @user}, status: 200
    else
      render json: {status: "false", message: "Error with your login or password"}, status: 401
    end
  end

  def destroy
    if @current_user
      sign_out @current_user
      render json: {status: "true", message: "Signed out"}, status: 200
    else
      render json: {status: "false", message: "Invalid token"}, status: 401
    end
  end

  private

  def user_params
    params.require(:user).permit :email, :password
  end

  def ensure_params_exist
    return if params[:user].present?
    render json: {status: "false", message: "Missing params"}, status: 422
  end
end
