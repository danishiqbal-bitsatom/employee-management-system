class RemoveEmployeeDetailFromAttendances < ActiveRecord::Migration[8.1]
  def change
     remove_reference :attendances, :employee_detail, foreign_key: true
     remove_reference :leave_requests, :employee_detail, foreign_key: true
  end
end
