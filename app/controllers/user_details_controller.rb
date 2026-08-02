class UserDetailsController < ApplicationController
  
  before_action :authenticate_user!
  before_action :set_employee , only: [:edit, :update, :destroy]
  before_action :require_hr_or_admin, except: [:index, :show]
  before_action :require_admin, only: [:destroy]
 

  def index
  # byebug
  if current_user.admin? || current_user.hr?
  @employee_details =  User.includes(:department).page(params[:page]).per(5)
  else
  @employee_details =  User.includes(:department).where(id: current_user.id)
  end


  @total_employees =  User.count

  @active_employees =  User.where(status: "active").count

  @inactive_employees =  User.where(status: "inactive").count

  @total_departments = Department.count

  @employee_details = @employee_details.search(params[:search]) if params[:search].present?
  @employee_details = @employee_details.filter_by_status(params[:status])
  @employee_details = @employee_details.sorted(params[:sort])

  end


  def show 
   begin
      @employee_detail = User.find(params[:id])
   rescue ActiveRecord::RecordNotFound
      redirect_to user_details_path, alert: "Employee detail not found."
   end

  end


  def new 
    @employee_detail = User.new
  end


  def create
    @employee_detail = User.new(user_details_params)
    if @employee_detail.save
      ActivityLogger.log_activity(user:current_user, action: "create", record: @employee_detail, description: "Created employee #{@employee_detail.name} by #{current_user.name}", ip_address: request.remote_ip)
      WelcomeEmailJob.perform_later(@employee_detail)
      redirect_to user_detail_path(@employee_detail), notice: "Employee detail was successfully created."
    else
      render :new
    end
  end


  def destroy
    # byebug
    @employee_detail.destroy 
    ActivityLogger.log_activity(user:current_user, action: "destroy", record: @employee_detail, description: "Deleted employee #{@employee_detail.name} by #{current_user.name}", ip_address: request.remote_ip)

    redirect_to user_details_path , notice: "Employee detail was successfully deleted."

  end


  def update

    if @employee_detail.update(user_details_params)
      ActivityLogger.log_activity(user:current_user, action: "update", record: @employee_detail, description: "Updated employee #{@employee_detail.name} by #{current_user.name}", ip_address: request.remote_ip)
      redirect_to user_detail_path(@employee_detail), notice: "Employee detail was successfully updated."
    else
      render :edit
    end
  end

  
  def edit
  end
   
  private

  def set_employee
    @employee_detail = User.find(params[:id])
  end
  
  def user_details_params
    params.require(:user).permit( :name, :email, :phone, :employee_id, :designation, :joining_date, :status, :department_id ) 
  end
end
