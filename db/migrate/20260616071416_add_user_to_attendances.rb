class AddUserToAttendances < ActiveRecord::Migration[8.1]
  def change
    add_reference :attendances, :user, foreign_key: true
    add_reference :leave_requests, :user, foreign_key: true
  end
end
