class UserMailer < Devise::Mailer
  default from: 'if_initiatives.mil'

  layout 'mailer'

  def send_message_welcome_to_new_user(user)
    @user = user
    mail(to: @user.email, subject: 'Ви успішно зареєструвались.')
  end
end
