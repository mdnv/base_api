class Api::UsersController < Api::BaseController
  before_action :ensure_params_exist

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

  private

  def user_params
    params.require(:user).permit :email, :password, :password_confirmation
  end
end
