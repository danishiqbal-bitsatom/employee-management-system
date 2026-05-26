class CreateEmployeeDetails < ActiveRecord::Migration[8.1]
  def change
    create_table :employee_details do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.integer :salary
      t.string :department
      t.integer :age

      t.timestamps
    end
  end
end
