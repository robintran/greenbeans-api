class Bean < ActiveRecord::Base
  USED_ON = { raftle: 'raftle', gift: 'gift', none: 'none'}

  attr_accessible :used_on, :code, :token_id, :is_checkout 

  belongs_to :token 

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
  end
end
