class AddAvailableLeavesToEmployeeDetails < ActiveRecord::Migration[8.1]
  def change
    add_column :employee_details, :available_leaves, :integer 
  end
end
