class Tool < ActiveRecord::Base
  has_many :character_tools
  has_many :characters,
    through: :character_tools

  validates :name, length: { minimum: 1 }
end
