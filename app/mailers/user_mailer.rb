class UserMailer < ApplicationMailer
  default from: 'notifications@payup.com'

  def welcome_email(email)
    @user = user
    @url = "http://localhost:3000/users/sign_in"
    mail(to: email, subject: 'Welcome to PayUp!')
  end
end
