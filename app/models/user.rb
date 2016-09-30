class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :email, :password, :password_confirmation, :remember_me, :agreement
  # attr_accessible :title, :body

  has_many :pups

  def admin
    # return true if self.id == 1
    # false
    true
  end

  def to_s
    email
  end
end
