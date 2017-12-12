class AdminController < ApplicationController
	before_action :authenticate_user_as_admin!

	ADMIN_EMAILS = ['hephzi@kiteka.com', 'admin@kiteka.com']

	def index

	end

	def authenticate_user_as_admin!
		unless ADMIN_EMAILS.include?(current_user.email)
			redirect_to root_path
		end
	end
end