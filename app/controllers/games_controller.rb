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
    @user = User.find_by(authentication_token: params[:auth_token] )
    @game = Game.create(board: INITIAL_BOARD, turn_counter: 1)
    @game.game_users.create(user_id: @user.id)
    render json: { game: @game }, status: :ok
  end

  def show
    @game = Game.find(params[:id])
    render json: { game: @game }, status: :ok
  end
end