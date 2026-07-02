class LeaveApprovedJob < ApplicationJob
  queue_as :default

  def perform(leave_request_id)
    # Do something later
      leave_request = LeaveRequest.find(leave_request_id)
      LeaveMailer.leave_approved(leave_request).deliver_now
      puts("------Successfully ran job and sent leave approved email-----------------------------")
  end
end
