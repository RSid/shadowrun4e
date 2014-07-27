class CharacterCraft < ActiveRecord::Base
  belongs_to :character,
    inverse_of: :character_crafts
  belongs_to :craft,
    inverse_of: :character_crafts

  validates :character_id, presence: true
  validates :craft_id, presence: true
end
