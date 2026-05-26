class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable,:timeoutable 

  has_many :products, dependent: :destroy

 enum :role, {
  employee: 0,
  hr: 1,
  admin: 2
}

  after_initialize :set_default_role, if: :new_record? # default role is Employee when a new user is created 

  private

  def set_default_role
    self.role ||= :employee
  end

end
