class UserMailer < Devise::Mailer
  default from: 'if_initiatives.mil'

  layout 'mailer'

  def send_message_welcome_to_new_user(user)
    @user = user
    mail(to: @user.email, subject: 'Ви успішно зареєструвались.')
  end

  def send_password_to_user(user, password)
    @user = user
    @user_password = password
    mail(to: @user.email, subject: 'Ваш тимчасовий пароль.')
  end
end
