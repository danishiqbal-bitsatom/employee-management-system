class LeaveRequestsController < ApplicationController

  helper_method :current_user_detail, :admin_or_hr?

  before_action :set_leave_request, only: [:edit, :update, :show, :approve, :reject , :destroy]
  before_action :require_hr_or_admin, only: [:approve, :reject]
  

  def index
    @leave_requests = admin_or_hr? ? LeaveRequest.includes(:user).order(created_at: :desc).page(params[:page]).per(5) : current_user_detail.leave_requests.order(created_at: :desc).page(params[:page]).per(5)

    @total_leaves = @leave_requests.total_count

    @sick_leaves = @leave_requests.where(leave_type: "sick_leave").count
    @casual_leaves = @leave_requests.where(leave_type: "casual_leave").count
    @paid_leaves = @leave_requests.where(leave_type: "paid_leave").count
    @maternity_leaves = @leave_requests.where(leave_type: "maternity_leave").count
    @paternity_leaves = @leave_requests.where(leave_type: "paternity_leave").count
    @unpaid_leaves = @leave_requests.where(leave_type: "unpaid_leave").count
    @optional_leaves = @leave_requests.where(leave_type: "optional_leave").count

  end

  def new
    @leave_request = LeaveRequest.new
  end

  def create
    @leave_request = current_user_detail.leave_requests.new(leave_request_params)
    if @leave_request.save
      User.where(role: [:admin, :hr]).find_each do |user|
      Notification.notify(recipient:user , notifiable: @leave_request, title: "New Leave Request Created by #{current_user_detail.name}.")
      end
      redirect_to leave_requests_path, notice: 'Leave request was successfully created.'
    else
      render :new
    end
  end

  def edit
    
  end

  def update
    if @leave_request.update(status: params[:status])
      redirect_to leave_requests_path, notice: 'Leave request status updated.'
    else
      redirect_to leave_requests_path, alert: 'Failed to update leave request status.'
    end
  end 

  def show
  end

  def destroy
    if @leave_request.pending?
      @leave_request.destroy
      redirect_to leave_requests_path, notice: 'Leave request was successfully deleted.'
    else
      redirect_to leave_requests_path, alert: 'Only pending leave requests can be deleted.'
    end
  end

  def approve
    if @leave_request.update(status: "approved")

      DeductLeaveBalanceJob.perform_later(@leave_request.id)
      LeaveApprovedJob.perform_later(@leave_request.id)
      Notification.notify(recipient: @leave_request.user, notifiable: @leave_request, title: "Your leave request has been approved.")
      
      redirect_to leave_requests_path, notice: 'Leave request approved.'
    else
      redirect_to leave_requests_path, alert: 'Failed to approve leave request.'
    end
   
  end
  
  def reject
    if @leave_request.update(status: "rejected")
      Notification.notify(recipient: @leave_request.user, notifiable: @leave_request, title: "Your leave request has been rejected.")
      redirect_to leave_requests_path, notice: 'Leave request rejected.'
    else
      redirect_to leave_requests_path, alert: 'Failed to reject leave request.'
    end
  end
  

  private

  def admin_or_hr?
    current_user.admin? || current_user.hr?
  end

  def require_hr_or_admin
    unless admin_or_hr?
      redirect_to leave_requests_path, alert: "You are not authorized to perform this action."
    end
  end

  def current_user_detail
  normalized_email = current_user.email.to_s.strip.downcase

  @current_employee_detail ||= User.find_by(
    "LOWER(email) = ?",
    normalized_email
  )
  end

  def leave_request_params
    params.require(:leave_request).permit(:reason,:start_date, :end_date, :leave_type)
  end

  def set_leave_request
    begin
       @leave_request = LeaveRequest.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to leave_requests_path, alert: "Leave request not found."
    end
  end
end
