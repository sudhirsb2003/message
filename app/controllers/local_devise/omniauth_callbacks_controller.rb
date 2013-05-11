class LocalDevise::OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def all
    user = User.from_omniauth(request.env["omniauth.auth"])
    if user.persisted?
      user.role = 'user'
      flash.notice = t(:signed_in, :scope => 'devise.sessions')
      log_sign_in user
      sign_in_and_redirect(user)
    else
      session["devise.user_attributes"] = user.attributes
      redirect_to new_user_registration_url
    end
  end
  alias_method :twitter, :all
 
end
