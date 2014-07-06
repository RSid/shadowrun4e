class Characterquality < ActiveRecord::Base
  belongs_to :character,
    inverse_of: :characterqualities
  belongs_to :quality,
    inverse_of: :characterqualities

  validates :character_id, presence: true
  validates :quality_id, presence: true

end

