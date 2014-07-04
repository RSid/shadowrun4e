class CharacterQuality < ActiveRecord::Base
  belongs_to :character,
    inverse_of: :character_qualities
  belongs_to :quality,
    inverse_of: :character_qualities

  validates :character_id, presence: true
  validates :quality_id, presence: true

end
