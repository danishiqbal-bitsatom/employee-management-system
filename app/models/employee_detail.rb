class EmployeeDetail < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :phone, presence: true, uniqueness: true
  validates :employee_id, presence: true, uniqueness: true
  validates :designation, presence: true
  validates :joining_date, presence: true
  validates :status, presence: true, inclusion: { in: ['active', 'inactive'] }


  belongs_to :department
end
