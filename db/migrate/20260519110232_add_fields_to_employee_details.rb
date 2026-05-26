class AddFieldsToEmployeeDetails < ActiveRecord::Migration[8.1]
  def change
    add_column :employee_details, :employee_id, :string
    add_column :employee_details, :designation, :string
    add_column :employee_details, :joining_date, :date
    add_column :employee_details, :status, :string
  end
end
