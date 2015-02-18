class GamesController < ApplicationController
  before_action :authenticate_user_from_token!


  def create
    @game = Game.create
    @game.users = [current_user]
    render json: { game: @game }, status: :created
  end

  def list
    @games = current_user.games
    render json: { game: @games }, status: :ok
  end

  def show
    @game = Game.find(params[:id])
    player1 = @game.users[0].username
    @game.users[1] ? player2 = @game.users[1].username : player2 = nil
    render json: { game: @game,  player1: player1, player2: player2 }, status: :ok
  end
end