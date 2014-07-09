class CharacterTool < ActiveRecord::Base
  belongs_to :character,
    inverse_of: :character_tools
  belongs_to :tool,
    inverse_of: :character_tools

  validates :character, presence: true
  validates :tool, presence: true
end
