class LeaveRequest < ApplicationRecord
  belongs_to :user
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :leave_type, presence: true
  validates :reason, presence: true

  enum :status, {pending: "pending",approved: "approved",rejected: "rejected"}
  enum :leave_type, {sick_leave: "sick_leave",casual_leave: "casual_leave",paid_leave: "paid_leave", maternity_leave: "maternity_leave", paternity_leave: "paternity_leave",unpaid_leave: "unpaid_leave", optional_leave: "optional_leave"}
  validate :end_date_after_start_date
  before_validation :calculate_total_days
  before_validation :set_default_status



  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end

  def calculate_total_days
    return if end_date.blank? || start_date.blank?

    self.total_days = (end_date - start_date).to_i + 1
  end

  def set_default_status
    self.status ||= "pending"
  end
end
