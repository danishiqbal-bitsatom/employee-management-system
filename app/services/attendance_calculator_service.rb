class AttendanceCalculatorService

  def initialize(attendance)
    @attendance = attendance
  end

  def call
    calculate_hours
    update_status
  end

  private

  def calculate_hours
    return unless @attendance.check_in && @attendance.check_out

    total_hours = (@attendance.check_out - @attendance.check_in) / 1.hour

    @attendance.working_hours = total_hours.round(2)
  end

  def update_status
    hours = @attendance.working_hours

    if hours >= 8
      @attendance.status = "present"
    elsif hours >= 4
      @attendance.status = "half_day"
    else
      @attendance.status = "absent"
    end
  end
end