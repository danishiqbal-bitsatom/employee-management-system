class CreateAttendances < ActiveRecord::Migration[8.1]
  def change
    create_table :attendances do |t|
      t.references :employee_detail, null: false, foreign_key: true
      t.date :attendance_date
      t.datetime :check_in
      t.datetime :check_out
      t.float :working_hours
      t.string :status

      t.timestamps
    end
  end
end
