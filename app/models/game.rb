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
    super(only: [:board, :turn_counter])
  end

  def player
    turn_counter.odd? ? 1 : 2
  end

  def valid_piece?(piece)
    return piece if player == 1 && self.board[piece[0]][piece[1]].odd? ||
                    player == 2 && self.board[piece[0]][piece[1]].even?
  end

  def move(move_arr)
    piece = valid_piece?(move_arr[0])
    if piece
      
    else
      return "Invalid Piece"
    end
  end

  def one_player?
    self.users.size == 1
  end

  def created_by?(user)
    self.users[0].id == user.id
  end

  private
  def init_game
    self.board = INITIAL_BOARD
    self.turn_counter = 1
  end
end