class AdminUser < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  # attr_accessible :title, :body
  
  @@owner_id = 1
  
  def AdminUser.true_admin? id
    id == @@owner_id
  end
  
  def AdminUser.change_owner id
    @@owner_id = id
  end
  
end
