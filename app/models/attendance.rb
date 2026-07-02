class Attendance < ApplicationRecord
  belongs_to :user

  validates :attendance_date,presence: true,uniqueness: { scope: :user_id,message: "User has already submitted attendance for this date" }
  validates :status, presence: true


  enum :status, { present: "present", absent: "absent", half_day: "half_day", on_leave: "on_leave" }
  # Status = %w[present absent half_day on_leave].freeze
  # validates :status, inclusion: { in: Status }

  # before_save :calculate_hours, if: -> { check_in.present? && check_out.present? }




  validate :check_out_after_check_in

  # Scopes

  scope :today, -> {
    where(attendance_date: Date.today)
  }

  scope :present_employees, -> {
    where(status: "present")
  }

  scope :absent_employees, -> { where(status: "absent") }

  scope :half_day_employees, -> { where(status: "half_day") }

  scope :on_leave_employees, -> { where(status: "on_leave") }

  scope :by_date, ->(date) {
    where(attendance_date: date)
  }

  scope :by_employee, ->(employee_id) {
    where(user_id: employee_id)
  }


  def check_out_after_check_in
    return unless check_in.present? && check_out.present?
    errors.add(:check_out, "must be after check-in time") if check_out <= check_in
  end


end
