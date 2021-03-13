class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates_uniqueness_of :auth_token
  before_create :generate_authentication_token!

  def generate_authentication_token!
    begin
    self.auth_token = Devise.friendy_token
    end while User.exists?(auth_token: auth_token)
  end
end 
