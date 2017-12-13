class RegistrationsController < Devise::RegistrationsController

  before_action :allowed_user?, only: [:create]
  
  protected

  def allowed_user?
  	allowed_users = AllowedUser.all.map(&:email)
  	email = params[:user][:email]
  	unless allowed_users.include?(email)
		set_flash_message!(:alert, :email_not_allowed)
		redirect_to new_user_registration_path
  	end
  end
end