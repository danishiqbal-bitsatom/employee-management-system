class RemoveFieldsFromEmployeeDetails < ActiveRecord::Migration[8.1]
  def change
    remove_column :employee_details, :age, :integer
    remove_column :employee_details, :city, :string
    remove_column :employee_details, :address, :string
    remove_column :employee_details, :salary, :integer
  end
end
