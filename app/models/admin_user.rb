class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable


  before_validation :generate_apikey, on: :create
  def generate_apikey
    self[:apikey]=SecureRandom.uuid
  end
end
