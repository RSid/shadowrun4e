class CharacterGear < ActiveRecord::Base
  belongs_to :character,
    inverse_of: :character_gears
  belongs_to :gear,
    inverse_of: :character_gears

  validates :character_id, presence: true
  validates :gear_id, presence: true

end
