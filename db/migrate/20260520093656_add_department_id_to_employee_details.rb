class AddDepartmentIdToEmployeeDetails < ActiveRecord::Migration[8.1]
  def change
    add_reference :employee_details, :department, null: true, foreign_key: true
  end
end
