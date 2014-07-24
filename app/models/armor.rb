class Armor < ActiveRecord::Base
  has_many :character_armors
  has_many :characters,
    through: :character_armor

  validates :name, length: { minimum: 1 }
end
