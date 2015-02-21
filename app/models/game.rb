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
    [(piece[0] + move[0]) / 2, (piece[1] + move[1]) / 2]
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
    self.board[move[0]][move[1]] = 3 if move[0] == 7 && self.board[move[0]][move[1]] == 1
    self.board[move[0]][move[1]] = 4 if move[0] == 0 && self.board[move[0]][move[1]] == 2
  end
  
  def check_moves(jump=false)
    (0..7).each_with_object([]) do |row, result|
      (0..7).each do |col|
        piece = [row, col]
        next unless valid_piece?(piece)
        return true if valid_move?(piece, jump).size > 0
      end
    end
    false  
  end

  def end_turn
    self.turn_counter += 1
    self.capture_counter -= 1
    unless self.check_moves || self.check_moves(true)
      if player1
        self.finished = 2
        self.users[0].losses += 1
        self.users[0].experience += 2
        self.users[1].wins += 1
        self.users[1].experience += 10
      else
        self.finished = 1
        self.users[0].wins += 1
        self.users[0].experience += 10
        self.users[1].losses += 1
        self.users[1].experience += 2
      end
    end
    if self.capture_counter == 0
      self.finished = 0
      self.users[0].draws += 1
      self.users[0].experience += 4
      self.users[1].draws += 1
      self.users[1].experience += 4
    end
    self.save
  end



  private
  def init_game
    self.board = INITIAL_BOARD
    self.turn_counter = 1
  end
end