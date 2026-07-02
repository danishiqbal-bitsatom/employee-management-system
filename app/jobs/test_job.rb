class TestJob < ApplicationJob
  queue_as :default

  def perform
    # Do something later
    puts "sidekiq Successfully working!"
  end
end
