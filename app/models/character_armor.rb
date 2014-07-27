class CharacterArmor < ActiveRecord::Base
  belongs_to :character,
    inverse_of: :character_armors
  belongs_to :armor,
    inverse_of: :character_armors

  validates :character_id, presence: true
  validates :armor_id, presence: true
end
