class UserMailer < ApplicationMailer
  default from: "notification@rottenmangoes.com"

  def deleted_user(user)
    @user = user
    mail(to: @user.email, subject: "Your account has been terminated by an admin.")
  end

end
