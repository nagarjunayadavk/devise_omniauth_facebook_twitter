class User
  include Mongoid::Document
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable,:omniauthable, :validatable,:omniauth_providers => [:facebook,:twitter]

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me,:username,:provider, :uid

  ## Database authenticatable
  field :username,            :type => String, :default => ""
  field :provider,            :type => String, :default => ""
  field :uid,                :type => String, :default => ""
  field :email,              :type => String, :default => ""
  field :encrypted_password, :type => String, :default => ""

  ## Recoverable
  field :reset_password_token,   :type => String
  field :reset_password_sent_at, :type => Time

  ## Rememberable
  field :remember_created_at, :type => Time

  ## Trackable
  field :sign_in_count,      :type => Integer, :default => 0
  field :current_sign_in_at, :type => Time
  field :last_sign_in_at,    :type => Time
  field :current_sign_in_ip, :type => String
  field :last_sign_in_ip,    :type => String

  ## Confirmable
  # field :confirmation_token,   :type => String
  # field :confirmed_at,         :type => Time
  # field :confirmation_sent_at, :type => Time
  # field :unconfirmed_email,    :type => String # Only if using reconfirmable

  ## Lockable
  # field :failed_attempts, :type => Integer, :default => 0 # Only if lock strategy is :failed_attempts
  # field :unlock_token,    :type => String # Only if unlock strategy is :email or :both
  # field :locked_at,       :type => Time

  ## Token authenticatable
  # field :authentication_token, :type => String

 #ominiauth authandication
  def self.from_omniauth_facebook(auth)
    
    # data = auth.extra.raw_info
    #  data.email='fake'+auth.uid+'@donarleague.com' if data.email.blank?
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.username = auth.info.name
        user.email = auth.info.email
        user.password = Devise.friendly_token[0,20]
        # user.avatar = auth.info.image
        user.save!   
      end
  end
  def self.from_omniauth_twitter(auth)
      where(auth.slice(:provider, :uid)).first_or_create do |user|
        user.provider = auth.provider
        user.uid = auth.uid
        user.username = auth.info.name
        user.email = 'fake'+auth.uid+'@donarleague.com'
        user.password = Devise.friendly_token[0,20]
        # user.avatar = auth.info.image
        user.save!
      end
  end

end
