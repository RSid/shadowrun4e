class CharacterCyberbioware < ActiveRecord::Base
  belongs_to :character,
    inverse_of: :character_cyberbiowares
  belongs_to :cyberbioware,
    inverse_of: :character_cyberbiowares

  validates :character_id, presence: true
  validates :cyberbioware_id, presence: true
  validates :essence_cost, presence: true
end
