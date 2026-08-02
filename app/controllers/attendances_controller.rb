class AttendancesController < ApplicationController
  helper_method :current_user_detail, :admin_or_hr?

  before_action :set_attendance, only: [:check_out]

  # Employee Attendance History
  def index
   

    @attendances = admin_or_hr? ? Attendance.all : current_user_attendance

    # Filter by date
    if params[:date].present?
      @attendances = @attendances.by_date(params[:date])
    end

    # Filter by employee (admin/hr only)
    if admin_or_hr? && params[:employee_id].present?
      @attendances = @attendances.by_employee(params[:employee_id])
    end

    @attendances = @attendances.page(params[:page]).per(5).order(attendance_date: :desc)
  end

  # Check-In
  def check_in

    #  byebug
    user = current_user_detail
    unless user.employee?
      redirect_to attendances_path, flash: { alert: "Employee profile not found for your account." }
      return
    end

    # Prevent duplicate attendance for same day
    existing_attendance = user.attendances.find_by(
      attendance_date: Date.today
    )

    if existing_attendance
      redirect_to attendances_path,
      flash: { alert: "Attendance already marked for today." }

      return
    end

    @attendance = user.attendances.new(
      attendance_date: Date.today,
      check_in: Time.current,
      status:  "present"
    )

    if @attendance.save
      User.where(role: [:admin, :hr]).find_each do |user|
      Notification.notify(recipient:user , notifiable: @attendance, title: "New Attendance Marked by #{current_user_detail.name}.")
      end
      redirect_to attendances_path,
      notice: "Check-In successful."
    else
      render :new
    end
  end

  # Check-Out
  def check_out

    if @attendance.check_out.present?
      redirect_to attendances_path,
      alert: "Already checked out."

      return
    end

    @attendance.check_out = Time.current

    # Service Object
    AttendanceCalculatorService.new(@attendance).call

    if @attendance.save
      User.where(role: [:admin, :hr]).find_each do |user|
      Notification.notify(recipient:user , notifiable: @attendance, title: "Attendance Updated by #{current_user_detail.name}.")
      end
      redirect_to attendances_path,
      notice: "Check-Out successful."
    else
      redirect_to attendances_path,
      alert: "Something went wrong."
    end
  end


#  all private methods 

  private

  def admin_or_hr?
    current_user.admin? || current_user.hr?
  end

  def current_user_attendance
    user = current_user_detail
    return Attendance.none unless user

    user.attendances
  end

  def current_user_detail
    normalized_email = current_user.email.to_s.strip.downcase
    @current_user_detail ||= User.find_by("LOWER(email) = ?", normalized_email)
  end

  def set_attendance
    user = current_user_detail
    unless user
      redirect_to attendances_path, alert: "User profile not found for your account."
      return
    end

    @attendance = user.attendances.find(params[:id])
  end

end