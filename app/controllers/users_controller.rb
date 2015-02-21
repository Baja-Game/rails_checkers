class UsersController < ApplicationController
  
  def index
    @users = User.order(experience: :desc)
    render json: @users, status: :ok
  end

  def show
    #binding.pry
    @user = User.find(params[:id]) 
    render json: @user, except: [:authentication_token], status: :ok
  end
end
