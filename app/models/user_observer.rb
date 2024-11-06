class UserObserver < ActiveRecord::Observer
  # changes to the user model is being watched by the observer
  observe :user

  # password reset notification instructions
  ActiveSupport::Notifications.subscribe('after_reset_password_instructions') do |*args|
    # new event object is being created due to received arguments
    event = ActiveSupport::Notifications::Event.new(*args)
    # the user object is being extracted due to event's payload
    user = event.payload

    # logs the users email address to the console, to which the password instructions where sent to
    puts "Password reset instructions sent to: #{user.email}"
  end
end
