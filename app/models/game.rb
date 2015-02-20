class Game < ActiveRecord::Base
  has_many :game_users
  has_many :users, through: :game_users

  validates_length_of :users, maximum: 2, message: "Only 2 players allowed."

  serialize :board

  before_create :init_game

  INITIAL_BOARD = [[0, 1, 0, 1, 0, 1, 0, 1],
                   [1, 0, 1, 0, 1, 0, 1, 0],
                   [0, 1, 0, 1, 0, 1, 0, 1],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [0, 0, 0, 0, 0, 0, 0, 0],
                   [2, 0, 2, 0, 2, 0, 2, 0],
                   [0, 2, 0, 2, 0, 2, 0, 2],
                   [2, 0, 2, 0, 2, 0, 2, 0]]

  def as_json(opts={})
    super(only: [:id, :board, :turn_counter, :finished, :updated_at])
  end

  def player1
    turn_counter.odd?
  end

  def valid_piece?(piece)
    return piece if player1 && self.board[piece[0]][piece[1]].odd? ||
                    !player1 && self.board[piece[0]][piece[1]].even?
  end

  def valid_move?(piece, jump=false)
    jump ? j = 2 : j = 1
    a, b = 0, 4
    a = 2 if self.board[piece[0]][piece[1]] == 1
    b = 2 if self.board[piece[0]][piece[1]] == 2
    [[piece[0] - 1 * j, piece[1] - 1 * j],
     [piece[0] - 1 * j, piece[1] + 1 * j],
     [piece[0] + 1 * j, piece[1] - 1 * j],
     [piece[0] + 1 * j, piece[1] + 1 * j]][a, b].select do |m|
      m[0].between?(0, 7) && m[1].between?(0, 7) && self.board[m[0]][m[1]] == 0
    end
  end

  # finds
  def jump_spot(piece, move)
    [(piece[0] + move[0]) / 2, (piece[1] + move[0]) / 2]
  end

  def can_jump?(piece, move)
    jspot = jump_spot(piece, move)
    jpiece = self.board[jspot[0]][jspot[1]]
    # An odd plus an even is always even, but an even plus an even or an
    # odd plus an odd are always odd, so this returns true if pieces are
    # from different players
    true if (self.board[piece[0]][piece[1]] + jpiece).odd?
  end

  def process_move(piece, move)
    self.board[move[0]][move[1]] = self.board[piece[0]][piece[1]] 
    self.board[piece[0]][piece[1]] = 0
  end

  def end_turn
    self.turn_counter += 1
    self.save
  end

  private
  def init_game
    self.board = INITIAL_BOARD
    self.turn_counter = 1
  end
end