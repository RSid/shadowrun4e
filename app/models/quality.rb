class Quality < ActiveRecord::Base
  has_many :character_qualities
  has_many :characters, through: :character_qualities


  validates :name, presence: true
  validates :description, presence: true

end
