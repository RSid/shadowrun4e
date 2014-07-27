class Craft < ActiveRecord::Base
  has_many :character_crafts
  has_many :characters,
    through: :character_crafts

  validates :name, length: { minimum: 1 }
end
