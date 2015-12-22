class Game < ActiveRecord::Base
  has_one :player1
  has_one :player2
  belongs_to :match

  validates :player1_score, presence: true, numericality: { only_integer: true }
  validates :player2_score, presence: true, numericality: { only_integer: true }
  validate :validate_scores

  def validate_scores
    score_diff = (player1_score - player2_score).abs

    # Games must be played to 11
    if player1_score < 11 && player2_score < 11
      errors.add(:score, "must be at least 11 points.")

    # Must win by 2
    elsif score_diff < 2
      errors.add(:score, "must be won by at least two points.")

    # Overtime must win by exactly 2
    elsif player1_score > 11 && score_diff > 2
      errors.add(:score, "must be won by exactly two points in overtime.")
    end
  end
end
