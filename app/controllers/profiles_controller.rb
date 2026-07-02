class ProfilesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_employee_detail , only: [:show, :edit, :update]

  def show
    # byebug

  end

  def edit
  end

  def update
    if @employee_detail.update(profile_params)
      redirect_to profile_path,notice: "Profile updated successfully."
    else
      render :edit
    end
  end
  

def destroy
  attachment = ActiveStorage::Attachment.find(params[:id])
  attachment.purge
  redirect_to profile_path, notice: "File removed successfully."
end

  private

  def set_employee_detail
    # byebug
    if current_user.admin? || current_user.hr?
       @employee_detail = params[:id].present? ? User.find(params[:id]) : current_user
    else
      @employee_detail = current_user
    end
   
  end

  def profile_params
    params.require(:user).permit(
      :name,
      :email,
      :profile_picture,
      :resume,
      :id_proof,
      documents: []
    )
  end
end