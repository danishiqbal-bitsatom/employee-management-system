class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,:recoverable, :rememberable, :validatable,:timeoutable 
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true
  validates :employee_id, presence: true, uniqueness: true
  validates :designation, presence: true
  validates :joining_date, presence: true
  validates :status, presence: true, inclusion: { in: ['active', 'inactive'] }

has_one_attached :profile_picture
has_one_attached :resume
has_many_attached :documents
has_one_attached :id_proof

belongs_to :department
has_many :attendances, dependent: :destroy
has_many :leave_requests, dependent: :destroy
before_validation  :generate_Password , on: :create
after_create_commit :assign_initial_leaves


 enum :role, {
  employee: 0,
  hr: 1,
  admin: 2
}
#  Scope for searching, filtering, and sorting users based on various criteria


scope :search, ->(query) {
  joins(:department).where(
    "users.name LIKE :query
    OR users.email LIKE :query
    OR users.designation LIKE :query
    OR departments.name LIKE :query",
    query: "%#{query}%"
  )
}

scope :filter_by_status, ->(status) {
  where(status: status) if status.present?
}

scope :sorted, ->(sort) {
  case sort
  when "joining_date"
    order(joining_date: :desc)
  when "department"
    joins(:department).order("departments.name ASC")
  else
    order(created_at: :desc)
  end
}

  after_initialize :set_default_role, if: :new_record? # default role is Employee when a new user is created 

  private

  def set_default_role
    self.role ||= :employee
  end

  def assign_initial_leaves
    AssignInitialLeavesJob.perform_later(self.id)
  end
  
  def generate_Password
    self.role = :employee
    self.password = "pass8090" if self.password.blank?
  end

end
