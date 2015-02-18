class GamesController < ApplicationController
  before_action :authenticate_user_from_token!


  def create
    @game = Game.create
    @game.users = [current_user]
    render json: { game: @game }, status: :created
  end

  def show
    @game = Game.find(params[:id])
    render json: { game: @game }, status: :ok
  end
end