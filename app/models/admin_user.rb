class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable


  before_validation :generate_apikey, on: :create

  validates_format_of :email, :with  => Devise.email_regexp, :allow_blank => true, :if => :email_changed?
  validates_presence_of   :password, on: :create
  validates_confirmation_of   :password, on: :create
  validates_length_of :password, :within => Devise.password_length, :allow_blank => true

  def generate_apikey
    self[:apikey]=SecureRandom.uuid
  end

  class << self
    def authenticate_by_apikey(apikey)
      find_by_apikey(apikey)
    end
  end
end
