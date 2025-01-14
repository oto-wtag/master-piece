class UserMailerJob < ApplicationJob
  queue_as :default

  def perform(user)
    Devise::Mailer.confirmation_instructions(user, user.confirmation_token).deliver_now
  end
end
