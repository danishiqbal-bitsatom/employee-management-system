class DeductLeaveBalanceJob < ApplicationJob
  queue_as :default

  def perform(leave_request_id)
    # Do something later
    puts "------Successfully ran job-----------------------------"
    leave_request = LeaveRequest.find(leave_request_id)
    employee = leave_request.user

    employee.update!(available_leaves: employee.available_leaves - leave_request.total_days)

  end
end
