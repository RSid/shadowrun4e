class CharacterArmor < ActiveRecord::Base
  belongs_to :character,
    inverse_of: :character_armor
  belongs_to :tool,
    inverse_of: :character_armor

  validates :character_id, presence: true
  validates :armor_id, presence: true
end
