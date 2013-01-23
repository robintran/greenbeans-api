class Bean < ActiveRecord::Base
  USED_ON = { raffle: 'raffle', gift: 'gift', none: 'none'}

  attr_accessible :used_on, :code, :token_id, :redeemed

  belongs_to :token 
  belongs_to :user
  
  scope :actives, lambda {where(used_on: USED_ON[:none], redeemed: false)}
  scope :redeemeds, lambda {where(redeemed: true)}
  scope :on_raffles, lambda {where(used_on: USED_ON[:raffle], redeemed: false)}
  
  
  validates :code, :presence => true, :uniqueness => true 

  before_validation :set_code_and_use_type 

  private 
  def set_code_and_use_type
    arr = [('0'..'9'),('A'..'Z')].map{|i| i.to_a}.flatten
    str = (0...6).map{ arr[rand(arr.length)] }.join
    while (Bean.where(:code => str).any?)
      str = (0...6).map{ arr[rand(arr.length)] }.join
    end
    self.code = str
    self.used_on = USED_ON[:none] unless self.used_on
    self.redeemed = false if self.redeemed.nil?
  end
end
