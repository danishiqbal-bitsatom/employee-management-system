class LeaveMailer < ApplicationMailer

  def leave_approved(leave_request)
    @leave_request = leave_request
    @user = leave_request.user

    mail(to: @user.email, subject: "Leave Request Approved")
  end

end
