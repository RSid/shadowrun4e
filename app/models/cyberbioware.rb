class Cyberbioware < ActiveRecord::Base
  has_many :character_cyberbiowares
  has_many :characters,
    through: :character_cyberbiowares

  validates :name, length: { minimum: 1 }
end
