class ActivityLogsController < ApplicationController
  before_action :authenticate_user!
  before_action :require_hr_or_admin
  def index
    @activity_logs = ActivityLog.includes(:user).order(created_at: :desc).page(params[:page]).per(10)
  end
end
