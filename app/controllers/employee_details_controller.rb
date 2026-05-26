class EmployeeDetailsController < ApplicationController

  before_action :authenticate_user!
  before_action :set_employee , only: [:edit, :update, :show, :destroy]
  before_action :require_hr_or_admin, except: [:index, :show]
  before_action :require_admin, only: [:destroy]


  def index
  @employee_details = EmployeeDetail.includes(:department).page(params[:page]).per(5)


  @total_employees = EmployeeDetail.count

  @active_employees = EmployeeDetail.where(status: "active").count

  @inactive_employees = EmployeeDetail.where(status: "inactive").count

  @total_departments = Department.count


  # Search Functionality
  if params[:search].present?
    search = "%#{params[:search]}%"

    @employee_details = @employee_details.joins(:department).where(
      "employee_details.name LIKE :search
      OR employee_details.email LIKE :search
      OR employee_details.designation LIKE :search
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
    @employee_detail = EmployeeDetail.new
  end


  def create
    @employee_detail = EmployeeDetail.new(employee_detail_params)
    if @employee_detail.save
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

    if @employee_detail.update(employee_detail_params)
      redirect_to @employee_detail, notice: "Employee detail was successfully updated."
    else
      render :edit
    end
  end

  
  def edit
  end

  private

  def set_employee
    @employee_detail = EmployeeDetail.find(params[:id])
  end
  
  def employee_detail_params
    params.require(:employee_detail).permit( :name, :email, :phone, :employee_id, :designation, :joining_date, :status, :department_id) 
  end
end
