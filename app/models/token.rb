class Token < ActiveRecord::Base
  attr_accessible :code, :merchant_id, :beans_count 
  attr_accessor :beans_count
  
  belongs_to :merchant
  has_many   :beans 

  validates :beans_count, numericality: {greater_than: 0}
  validates :code, :presence => true, :uniqueness => true 
  validates_presence_of :merchant_id
  
  before_validation :generate_code 
  after_create :generate_beans
  
  def create_beans(quantity)
    quantity.times do 
      self.beans.create 
    end
  end
  
  private
    def generate_beans
      self.beans_count.times do 
        self.beans.create 
      end
    end
    
    def generate_code 
      arr = [('0'..'9'),('A'..'Z')].map{|i| i.to_a}.flatten
      str = (0...5).map{ arr[rand(arr.length)] }.join
      while (Bean.where(:code => str).any?)
        str = (0...5).map{ arr[rand(arr.length)] }.join
      end
      self.code = str    
    end
end
