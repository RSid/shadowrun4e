class CharacterSkill < ActiveRecord::Base
  belongs_to :character,
    inverse_of: :character_skills
  belongs_to :skill,
    inverse_of: :character_skills

  validates :character_id, presence: true
  validates :skill_id, presence: true
  validates :rating, presence: true
  validates :specialization, presence: true

  def roll

    rolls_array = []
    self.rating.times {rolls_array << rand(1..6)}
    rolls_array
  end


end



