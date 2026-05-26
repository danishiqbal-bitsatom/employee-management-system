class Department < ApplicationRecord
  has_many :employee_details

  validates :name, presence: true
end
