class Raffle < ActiveRecord::Base
  belongs_to :merchant
  attr_accessible :description, :drawing_time, :instructions, :name, :num_of_winner, :repeat
  
  has_one :prize
  
  validates :name, presence: true
  validates :num_of_winner, presence: true
end
