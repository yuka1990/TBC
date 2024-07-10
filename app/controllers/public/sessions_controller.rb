# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_inactive_user, only: [:create]


  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  
  def after_sign_in_path_for(resource)
    my_page_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end
  
  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to my_page_path, notice: "Logged in as Guest User"
  end
  
  private
  
   def reject_inactive_user
    @user = User.find_by(email: params[:user][:email])
    if @user
      if @user.valid_password?(params[:user][:password]) && !@user.is_active
        flash[:alert] = 'You have already canceled your membership. We are sorry, but please use another e-mail address.'
        redirect_to new_user_registration_path
      end
    end
   end

end
