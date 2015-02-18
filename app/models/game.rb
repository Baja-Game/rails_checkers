class Game < ActiveRecord::Base
  has_many :game_users
  has_many :users, through: :game_users

  validates_length_of :users, maximum: 2, message: "Only 2 players allowed."

  serialize :board

end