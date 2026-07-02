class WelcomeEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    # Do something later
    UserMailer.welcome_email(user).deliver_now
   puts("------Successfully ran job and sent welcome email-----------------------------")
  end
end
