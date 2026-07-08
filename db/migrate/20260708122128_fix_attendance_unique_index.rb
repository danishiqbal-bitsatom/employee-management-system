class FixAttendanceUniqueIndex < ActiveRecord::Migration[8.1]
  def change
    remove_index :attendances, name: "index_attendances_on_employee_detail_and_date"
    add_index :attendances, [:user_id, :attendance_date], unique: true, name: "index_attendances_on_user_and_date"
  end
end
