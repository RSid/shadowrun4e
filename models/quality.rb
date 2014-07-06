class Quality < ActiveRecord::Base
  has_many :characterqualities
  has_many :characters, through: :character_qualities


  validates :name, presence: true
  validates :description, presence: true

end
