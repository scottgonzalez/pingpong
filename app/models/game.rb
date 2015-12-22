class Game < ActiveRecord::Base
  has_one :player1
  has_one :player2
  belongs_to :match

  validates :player1_score, presence: true, numericality: true
end
