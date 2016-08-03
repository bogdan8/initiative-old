module Users
  class OmniauthCallbacksController < Devise::OmniauthCallbacksController
    def twitter
      user = User.from_omniauth(env['omniauth.auth'])
      if user.persisted?
        sign_in_and_redirect user, notice: 'Ви успішно увійшли!'
      else
        redirect_to new_user_registration_url
        session['devise.user_attributes'] = user.attributes
      end
    end

    def facebook
      user = User.from_omniauth(env['omniauth.auth'])
      if user.persisted?
        sign_in_and_redirect user, notice: 'Ви успішно увійшли!'
      else
        redirect_to new_user_registration_url
        session['devise.user_attributes'] = user.attributes
      end
    end

    def destroy
      session[:user_id] = nil
      redirect_to root_url, notice: 'Ви успішно вийшли!'
    end
  end
end
