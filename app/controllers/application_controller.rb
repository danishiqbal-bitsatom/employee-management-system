class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  before_action :authenticate_user!
  before_action :set_no_cache_for_auth_pages

  before_action :configure_permitted_parameters, if: :devise_controller?

  private
  def set_no_cache_for_auth_pages
    if devise_controller?
      response.headers["Cache-Control"] = "no-store, no-cache, must-revalidate, max-age=0"
      response.headers["Pragma"] = "no-cache"
      response.headers["Expires"] = "0"
    end
  end

  def require_admin
    unless current_user.admin?
      redirect_to root_path, alert: "Access Denied"
    end   
  end

  def require_hr_or_admin
    unless current_user.hr? || current_user.admin?
      redirect_to root_path, alert: "Access Denied"
  end
  end

  # Changes to the importmap will invalidate the etag for HTML responses
  stale_when_importmap_changes
  protected

  def after_sign_up_path_for(resource)
    sign_out current_user # Sign out the user after sign up
    new_user_session_path
  end

  protected
   def configure_permitted_parameters
     devise_parameter_sanitizer.permit(:sign_up, keys: [:name , :role])
   end
 
  
end
