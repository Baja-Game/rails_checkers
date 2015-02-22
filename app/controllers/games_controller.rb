class GamesController < ApplicationController
  before_action :authenticate_user_from_token!

  def create
    render json: show_results(make_game), status: :created
  end

  def list
    @games = current_user.games.to_a
    @games.map! { |g| show_results(g) }
    render json: @games, status: :ok
  end

  def move
    @game = Game.find(params[:id])
    params[:move] == 'forfeit' ? moves = 'forfeit' : moves = JSON.parse(params[:move])
    @game.log << moves
    @game.player1 ? valid_user = @game.users[0] : valid_user = @game.users[1]
    if valid_user != current_user
      render json: { message: 'Invalid Player' }, status: :bad_request
    elsif moves == 'forfeit'
      @game.forfeit
      @game.end_turn
      render json: { message: "Player #{@game.finished} Wins By Forfeit"}, status: :ok
    else
      possible_jumps = @game.check_jumps
      piece = @game.valid_piece?(moves.shift)
      if piece
        if @game.valid_move?(piece).include?(moves[0])
          if @game.forced_jumps? && @game.check_jumps.size > 0
            result = 'jump'
          else  
            @game.process_move(piece, moves[0])
          end
        else
          moves.each do |m|
            if @game.valid_move?(piece, jump = true).include?(m) && 
               @game.can_jump?(piece, m)
              @game.process_move(piece, m)
              x = @game.jump_spot(piece, m)
              @game.board[x[0]][x[1]] = 0
              @game.capture_counter = 40
              piece = m
            else
              result = 'invalid'
            end  
          end
          result = 'jump' if @game.valid_move?(moves[-1], true).size > 0
        end
        @game.end_turn unless result
        if @game.finished
          render json: { message: "Player #{@game.finished} Wins"}, status: :ok
        else
          if result 
            if result == 'jump'       
              render json: { message: 'Player Must Jump' }, status: :bad_request
            else
              render json: { message: 'Invalid Move' }, status: :bad_request
            end
          else
            render json: { message: 'Move Successful' }, status: :ok
          end
        end
      else
        render json: { message: 'Invalid Piece' }, status: :bad_request
      end
    end
  end

  def show
    @game = Game.find(params[:id])
    render json: show_results(@game), status: :ok
  end

  def join
    fjumps = params[:jumps] || true
    fjumps = false if fjumps == 'false'
    level = ((current_user.experience / 10)**0.5).floor
    available_game = Game.joins(:users).
                          where(game_users_count: 1,
                                level: (level-1)..(level+1),
                                forced_jumps: fjumps).
                          where("users.id != #{current_user.id}").first
    if available_game
      available_game.users << current_user
      render json: show_results(available_game), status: :created
    else
    render json: show_results(make_game(fjumps)), status: :created
    end

  end

  private
  def make_game(fjumps = true)
    @game = Game.create(level: ((current_user.experience / 10)**0.5).floor,
                        forced_jumps: fjumps)
    @game.users << current_user
    @game
  end

  def show_results(g)
    x = g.users[0]
    y = g.users[1]
    player1 = { id: x.id, username: x.username }
    y ? player2 = { id: y.id, username: y.username } : player2 = nil
    { game: g,  player1: player1, player2: player2 }
  end

end
