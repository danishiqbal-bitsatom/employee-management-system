class AddAddressToEmployeeDetails < ActiveRecord::Migration[8.1]
  def change
    add_column :employee_details, :address, :string
  end
end
