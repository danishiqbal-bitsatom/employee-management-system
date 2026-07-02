class EmployeeDetail < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true
  validates :employee_id, presence: true, uniqueness: true
  validates :designation, presence: true
  validates :joining_date, presence: true
  validates :status, presence: true, inclusion: { in: ['active', 'inactive'] }

  # after_create_commit :assign_initial_leaves

  has_one_attached :profile_picture
  has_one_attached :resume
  has_many_attached :documents
  has_one_attached :id_proof



  belongs_to :department
  has_many :attendances, dependent: :destroy
  has_many :leave_requests, dependent: :destroy

  # private
  # def assign_initial_leaves
  #   AssignInitialLeavesJob.perform_later(self.id)
  # end
end
