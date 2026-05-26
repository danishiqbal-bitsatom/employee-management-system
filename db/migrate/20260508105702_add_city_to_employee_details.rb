class AddCityToEmployeeDetails < ActiveRecord::Migration[8.1]
  def change
    add_column :employee_details, :city, :string
  end
end
