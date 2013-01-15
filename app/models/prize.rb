class Prize < ActiveRecord::Base
  belongs_to :raffle
  attr_accessible :p_type, :tier
end
