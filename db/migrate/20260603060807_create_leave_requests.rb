class CreateLeaveRequests < ActiveRecord::Migration[8.1]
  def change
    create_table :leave_requests do |t|
      t.string :leave_type
      t.string :status
      t.date :start_date
      t.date :end_date
      t.integer :total_days
      t.references :employee_detail, null: false, foreign_key: true

      t.timestamps
    end
  end
end
