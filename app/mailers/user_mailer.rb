class UserMailer < ApplicationMailer
    def password_reset(user)
      @user = user
      @token = user.reset_password_token
      @reset_link = edit_user_password_url(reset_password_token: @user.reset_password_token, host: "Localhost", port: 3000)
      mail(to: @user.email, subject: "Reset Your Password")
    end
end
