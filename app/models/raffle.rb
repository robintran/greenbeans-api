class Raffle < ActiveRecord::Base
  belongs_to :merchant
  attr_accessible :description, :drawing_time, :instructions, :name, :num_of_winner, :repeat, :prize_attributes
  
  has_one :prize
  accepts_nested_attributes_for :prize
  
  validates :name, presence: true
  validates :num_of_winner, presence: true, numericality: true
  
  scope :actives, lambda {where(['drawing_time > ?', DateTime.now])}
  
end
