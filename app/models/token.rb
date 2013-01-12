class Token < ActiveRecord::Base
  attr_accessible :code, :merchant_id 

  belongs_to :merchant
  has_many   :beans 

  validates :code, :presence => true, :uniqueness => true 
  validates_presence_of :merchant_id

  before_validation :generate_code 

  def create_beans(quantity)
    quantity.times do 
      self.beans.create 
    end
  end
  
  private
  def generate_code 
    arr = [('0'..'9'),('A'..'Z')].map{|i| i.to_a}.flatten
    str = (0...5).map{ arr[rand(arr.length)] }.join
    while (Bean.where(:code => str).any?)
      str = (0...5).map{ arr[rand(arr.length)] }.join
    end
    self.code = str    
  end
end
