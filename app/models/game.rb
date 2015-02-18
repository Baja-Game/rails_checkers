class Game < ActiveRecord::Base
  has_many :game_users
  has_many :users, through: :game_users

  validates_length_of :users, maximum: 2, message: "Only 2 players allowed."

  serialize :board

  def as_json(opts={})
    super(only: [:board, :turn_count])
  end

  def player
    turn_count.odd? ? self.game_users.first : self.game_users.last
  end

  def valid_piece?(piece)

  end

  def move(move_arr)
    piece = move_arr[0]
  end
end