class Prize < ActiveRecord::Base
  belongs_to :raffle
  attr_accessible :p_type, :tier
  
  TYPE = ['money', 'gift', 'vourcher']
  
  validates :p_type, :inclusion => { :in => TYPE }
end
