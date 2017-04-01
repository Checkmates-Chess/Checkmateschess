class User < ApplicationRecord
  has_many :pieces
  has_many :games
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

  validates :username, presence: true, length: { minimum: 3,
   maximum: 30 }
  validates_uniqueness_of :username
  
  # from_auth method tries to find an existing user by the provider and uid fields. If no user is found, a new one is created with a random password and some extra information. Note that the first_or_create method automatically sets the provider and uid fields when creating a new user.
  def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
	  	user.username = auth.info.email
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    #user.name = auth.info.name   # assuming the user model has a name
	    #user.image = auth.info.image # assuming the user model has an image
	    # If you are using confirmable and the provider(s) you use validate emails, 
	    # uncomment the line below to skip the confirmation emails.
	    #user.skip_confirmation!
	  end
	end
end
