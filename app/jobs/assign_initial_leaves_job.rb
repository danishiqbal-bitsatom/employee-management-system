class AssignInitialLeavesJob < ApplicationJob
  queue_as :default

  def perform(user_detail_id)
    # Do something later
    puts "------Successfully ran job and assigned initial leaves-----------------------------"
    employee = User.find(user_detail_id)
    employee.update!(available_leaves: 12)
  end
end
