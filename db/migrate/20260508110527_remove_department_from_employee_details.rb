class RemoveDepartmentFromEmployeeDetails < ActiveRecord::Migration[8.1]
  def change
    remove_column :employee_details, :department, :string
  end
end
