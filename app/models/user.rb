require 'bcrypt'

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :agreement
  # attr_accessible :title, :body
  
  attr_accessor :reset_token, :remember_token, :activation_token, :activation_digest
  before_save   :downcase_email
  before_create :create_activation_digest
  
  has_many :pups
  
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  

  # Returns true if the given token matches the digest.
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
  
  
 # Sets the password reset attributes.
  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_password_token,  User.digest(reset_token))
    update_attribute(:reset_password_sent_at, Time.zone.now)
  end
  
  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end
  
  # Converts email to all lower-case.
  def downcase_email
    self.email = email.downcase
  end
  
  def activated?
    @user = User.find(id)
    @user.activated
  end
  #######################################################################
  #may not need active function
  # Activates an account.
  def activate
    update_attribute(:activated,    true)
    # no  need time limte
    # update_attribute(:activated_at, Time.zone.now)
  end
  
    #Sends activation email.
  def send_activation_email
    UserMailer.account_activation(self).deliver_now
    return nil;
  end
  
  
  #Creates and assigns the activation token and digest.
  def create_activation_digest
    self.activation_token  = User.new_token
    self.activation_digest = User.digest(activation_token)
  end
  ########################################################################
# Returns a random token.
  def self.new_token
    SecureRandom.urlsafe_base64
  end
  
  def admin
    return true if self.email == "lhsdvm@aol.com"
    false
  end

  def to_s
    email
  end
end
