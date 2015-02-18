class GamesController < ApplicationController
  before_action :authenticate_user_from_token!

  INITIAL_BOARD = [[0, 1, 0, 1, 0, 1, 0, 1],
                   [1, 0, 1, 0, 1, 0, 1, 0],
                   [0, 1, 0, 1, 0, 1, 0, 1],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [2, 0, 2, 0, 2, 0, 2, 0],
                   [0, 2, 0, 2, 0, 2, 0, 2],
                   [2, 0, 2, 0, 2, 0, 2, 0]]

  def create
    @game = Game.create(board: INITIAL_BOARD, turn_counter: 1)
    @game.game_users.create(user_id: current_user.id)
    render json: { game: @game }, status: :ok
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