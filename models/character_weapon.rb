class CharacterWeapon < ActiveRecord::Base
  belongs_to :character,
    inverse_of: :character_weapons
  belongs_to :weapon,
    inverse_of: :character_weapons

  validates :character_id, presence: true
  validates :weapon_id, presence: true

end
