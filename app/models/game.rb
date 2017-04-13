class Game < ApplicationRecord
  has_many :pieces
  belongs_to :user

  validates :game_title, presence: true, length: { minimum: 3,
    maximum: 30 }

  scope :available, -> { where(player_black_id: nil).or(where(player_white_id: nil)) }
end
