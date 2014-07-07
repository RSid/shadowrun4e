class Skill < ActiveRecord::Base
  has_many :character_skills
  has_many :characters,
    through: :character_skills

  validates :name, length: { minimum: 1 }
end
