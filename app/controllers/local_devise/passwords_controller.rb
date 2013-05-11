class LocalDevise::PasswordsController < Devise::PasswordsController

  def create
    user_email = fetch_email(resource_params[:username]) if resource_params[:username]
    unless user_email.blank?
      resource_params = {:email => user_email}
      self.resource = resource_class.send_reset_password_instructions(resource_params)
      unless successfully_sent?(resource)
        flash[:error] = t(:unable_send_password_email, :scope => 'devise.failure') if is_navigational_format?
      end
    else
        flash[:error] = t(:unable_to_find_email, :scope => 'myinfo.devise.failure') if is_navigational_format?
    end
    redirect_to dashboard_path
  end

  private
  
  def fetch_email(username)
    user = User.find_by_username(username) if username
    user.email if user
  end

end
