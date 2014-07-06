class Weapon < ActiveRecord::Base
  has_many :character_weapons
  has_many :characters, through: :character_weapons


  validates :name, presence: true
  validates :damage, presence: true
  validates :damage_type, presence: true
  validates :melee, presence: true # inclusion:[ true, false]
end
