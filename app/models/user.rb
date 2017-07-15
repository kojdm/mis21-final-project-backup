class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable
         
  belongs_to :admin
  
  def activate!
      update_attribute :status, true
  end
    
  def deactivate!
      update_attribute :status, false
  end
  
  def active_for_authentication?
    super and self.status?
  end
end
