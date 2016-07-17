class CreateUserMailer < Devise::Mailer
  default from: 'if_initiatives.mil'

  layout 'mailer'

  def send_new_user_message(user)
    @user = user
    mail(to: @user.email, subject: 'Ви успішно зареєструвались.')
  end
end
