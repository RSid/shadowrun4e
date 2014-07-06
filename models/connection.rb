class Connection < ActiveRecord::Base
  belongs_to :character

  validates :name, presence: true
  validates :loyalty, presence: true
  validates :connection, presence: true
  validates :character_id, presence: true

end
