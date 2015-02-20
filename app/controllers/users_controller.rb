class UsersController < ApplicationController
  def show
    #binding.pry
    @user = User.find(params[:id]) 
    render json: @user, except: [:authentication_token], status: :ok
  end
end
