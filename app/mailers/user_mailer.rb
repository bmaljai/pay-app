class UserMailer < ApplicationMailer
  default from: 'notifications@payup.com'

  def welcome_email(email, user, debt_amount, debt_name, debt_link)
    @user = user
    @debt_amount = debt_amount
    @debt_name = debt_name
    @debt_link = debt_link
    @url = "http://localhost:3000/users/sign_in"
    mail(to: email, subject: 'Time to PayUp!')
  end
end
