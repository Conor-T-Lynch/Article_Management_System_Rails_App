class User < ApplicationRecord
  # devise modules that are included for user management and authentication
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Association with articles
  has_many :articles

  # method for sending password reset instructions overriden
  def send_reset_password_instructions
    # original method being called that performs the actual password reset instructions
    #super

    UserMailer.password_reset(self).deliver_now

    # logs the password reset link to the console after the original method is called
    puts "Password reset link sent: #{reset_password_link}"
  end

  private
  # constructing the password reset link with a helper method
  def reset_password_link
    # password reset URL link is built by using the app's host and reset password token
    "#{Rails.application.routes.default_url_options[:host]}/users/password/edit?reset_password_token=#{reset_password_token}"
  end
end
