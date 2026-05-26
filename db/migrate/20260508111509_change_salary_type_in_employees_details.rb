class ChangeSalaryTypeInEmployeesDetails < ActiveRecord::Migration[8.1]
  def change
    change_column :employee_details, :salary, :bigint
  end
end
