class AddEmployeeFieldsToUsers < ActiveRecord::Migration[8.1]
  def change
    add_column :users, :phone, :string
    add_column :users, :employee_id, :string
    add_column :users, :designation, :string
    add_column :users, :joining_date, :date
    add_column :users, :status, :string
    add_column :users, :available_leaves, :integer, default: 0

    add_reference :users, :department, foreign_key: true
  end
end
