class Character < ActiveRecord::Base

  belongs_to :user

  has_many :character_skills, dependent: :destroy
  has_many :skills,
    through: :character_skills

  has_many :characterqualities, dependent: :destroy
  has_many :qualities, through: :characterqualities

  has_many :connections, dependent: :destroy

  has_many :character_weapons, dependent: :destroy
  has_many :weapons, through: :character_weapons

  belongs_to :metatype

  validates :name, presence: true
  validates :user_id, presence: true
  validates :metatype_id, presence: true
  validates :body, presence: true
  validates :agility, presence: true
  validates :reaction, presence: true
  validates :strength, presence: true
  validates :charisma, presence: true
  validates :intuition, presence: true
  validates :logic, presence: true
  validates :willpower, presence: true
  validates :edge, presence: true
  validates :nuyen, presence: true
  validates :essence, presence: true
  validates :initiative_passes, presence: true

  def roll(skill, modifiers = 0, edge_used = false)
    results = []
    dice = skill + modifiers
    dice.times { results << rand(6) }
    results
  end

  def change_nuyen(amount)
    self.nuyen = self.nuyen + amount
  end
end
