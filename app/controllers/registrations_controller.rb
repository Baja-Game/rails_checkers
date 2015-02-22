class RegistrationsController < Devise::RegistrationsController
  def create
    @user = User.new(user_params)
    if @user.save
      render json: { user: @user, auth_token: @user.authentication_token }, status: :created
    else
      render json: { messages: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  def update
    :authenticate_user_from_token!
    @user = current_user
    if @user.save
      render json: { user: @user, auth_token: @user.authentication_token }, status: :ok
    else
      render json: { messages: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  private
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end