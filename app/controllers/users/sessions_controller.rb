# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  layout "users_layout"
  
  # GET /resource/sign_in
  def new
    session.delete('devise.omniauth_data')
    super
  end

  # POST /resource/sign_in
  def create
    if verify_recaptcha
      super
    else 
      render "devise/sessions/new"
    end   
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
