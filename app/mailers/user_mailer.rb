class UserMailer < ApplicationMailer
  def alert_set(user)
    @user = user

    mail(to: @user.email, subject: 'Your alert has been set')
  end
end
