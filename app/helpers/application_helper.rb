module ApplicationHelper
  def current_user_profile_path
    if user_signed_in?
      employee_detail = EmployeeDetail.find_by(email: current_user.email)
      employee_detail ? profile_path(employee_detail) : "#"
    else
      "#"
    end
  end
end
