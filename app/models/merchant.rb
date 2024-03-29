class Merchant < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :token_authenticatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name

  has_many :raffles
  has_many :tokens 
  
  validates_presence_of :email, :name
  validates :name, uniqueness: true
  after_create :generate_first_token 

  private 
  def generate_first_token 
    self.tokens.create 
  end
end
