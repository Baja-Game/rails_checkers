class GamesController < ApplicationController
  before_action :authenticate_user_from_token!


  def create
    render json: show_results(make_game), status: :created
  end

  def list
    @games = current_user.games.to_a
    @games.map! { |g| show_results(g) }
    render json: { game: @games }, status: :ok
  end

  def show
    @game = Game.find(params[:id])
    render json: show_results(@game), status: :ok
  end

  def join
    available_game = Game.joins(:users).where(game_users_count: 1).
                           where("users.id != #{current_user.id}").first
    if available_game
      available_game.users << current_user
      render json: show_results(available_game), status: :created
    else
    render json: show_results(make_game), status: :created
    end

  end

  private
  def make_game
    @game = Game.create
    @game.users << current_user
    @game
  end

  def show_results(g)
    player1 = g.users[0].username
    g.users[1] ? player2 = g.users[1].username : player2 = nil
    { game: g,  player1: player1, player2: player2 }
  end
end
