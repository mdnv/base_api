class Api::UsersController < Api::BaseController
  before_action :ensure_params_exist
  before_action :authenticate_user_from_token, only: :update_profile

  respond_to :json

  def create
    @user = User.new user_params

    if @user.save
      @user.update(
          authentication_token: Devise.friendly_token,
          authentication_token_created_at: Time.now
      )

      render json: {status: "success", user: @user, message: "Registration success"}, status: 200
    else
      render json: {status: "false", message: @user.errors.full_messages.uniq}, status: 422
    end
  end

  def update_profile
    unless @current_user.update_attributes user_params
      render json: { status: "false", message: @current_user.errors.full_messages.uniq }, status: 422
    end
  end

  private

  def user_params
    params.require(:user).permit :email, :password, :password_confirmation, profile_attributes: [:id, :avatar, :phone, :gender, :birthday]
  end

  def ensure_params_exist
    return if params[:user].present?
    render json: {status: "false", message: "Missing params"}, status: 422
  end
end
