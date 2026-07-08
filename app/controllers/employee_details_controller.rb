class EmployeeDetailsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_employee , only: [:edit, :update, :show, :destroy]
  before_action :require_hr_or_admin, except: [:index, :show]
  before_action :require_admin, only: [:destroy]


  def index

  @employee_details =  User.includes(:department).page(params[:page]).per(5)

  @total_employees =  User.count

  @active_employees =  User.where(status: "active").count

  @inactive_employees =  User.where(status: "inactive").count

  @total_departments = Department.count


  # Search Functionality
  if params[:search].present?
    search = "%#{params[:search]}%"

    @employee_details = @employee_details.joins(:department).where(
      "users.name LIKE :search
      OR users.email LIKE :search
      OR users.designation LIKE :search
      OR departments.name LIKE :search",
      search: search
    )
  end

  # Status Filter
  if params[:status].present?
      @employee_details = @employee_details.where(status: params[:status])
  end

  # Sorting
  case params[:sort]
  when "joining_date"
      @employee_details = @employee_details.order(joining_date: :desc)

  when "department"
     @employee_details = @employee_details.joins(:department).order("departments.name ASC") # by default it left join

  else
      @employee_details = @employee_details.order(created_at: :desc)
  end
  end


  def show 
  end


  def new 
    @employee_detail = User.new
  end


  def create
    @employee_detail = User.new(user_details_params)
    @employee_detail.role = :employee
    @employee_detail.password = "pass8090"

    if @employee_detail.save
      Notification.notify(recipient: @employee_detail, notifiable: @employee_detail, title: "Your employee account has been created.")
      redirect_to @employee_detail, notice: "Employee detail was successfully created."
    else
      render :new
    end
  end


  def destroy
    @employee_detail.destroy

    redirect_to employee_details_path
  end


  def update

    if @employee_detail.update(user_details_params)
        redirect_to @employee_detail, notice: "Employee detail was successfully updated."
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
