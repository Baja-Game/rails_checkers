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
    turn_count.odd? ? self.game_users.first : self.game_users.last
  end

  def valid_piece?(piece)

  end

  def move(move_arr)
    piece = move_arr[0]
  end

  private
  def init_game
    self.board = INITIAL_BOARD
    self.turn_counter = 1
  end
end