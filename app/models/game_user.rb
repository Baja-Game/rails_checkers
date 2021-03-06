class GameUser < ActiveRecord::Base
  belongs_to :game, counter_cache: true
  belongs_to :user

  validates_uniqueness_of :user_id, scope: :game_id
end
