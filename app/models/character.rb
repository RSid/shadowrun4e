class Character < ActiveRecord::Base
  belongs_to :user

  has_many :character_skills, dependent: :destroy
  has_many :skills,
    through: :character_skills

  has_many :character_qualities, dependent: :destroy
  has_many :qualities, through: :character_qualities

  has_many :connections, dependent: :destroy

  has_many :character_weapons, dependent: :destroy
  has_many :weapons, through: :character_weapons

  has_many :character_tools, dependent: :destroy
  has_many :tools, through: :character_tools

  has_many :character_armors, dependent: :destroy
  has_many :armors, through: :character_armors

  has_many :character_crafts, dependent: :destroy
  has_many :crafts, through: :character_crafts

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

  def mutable_attributes
    attributes.to_a.map{ |x| x[0] }.reject!{ |x| (x=="user_id" || x =="id" || x =="gm_id" || x == "metatype_id") }
  end
end
