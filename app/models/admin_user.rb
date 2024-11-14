class AdminUser < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :validatable

  # Explicitly define the searchable attributes for Ransack
  def self.ransackable_attributes(auth_object = nil)
    # List the attributes you want to allow for searching
    ["id", "email", "created_at", "updated_at", "remember_created_at", "reset_password_sent_at"]
  end
end
