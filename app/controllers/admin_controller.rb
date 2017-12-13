class AdminController < ApplicationController
	before_action :authenticate_user_as_admin!

	ADMIN_EMAILS = ['hephzi@kiteka.com', 'emmavioletmakinson@gmail.com']

	def index
		@questions = Question.all
		@allowed_users = AllowedUser.all
	end

	def authenticate_user_as_admin!
		unless ADMIN_EMAILS.include?(current_user.email)
			redirect_to root_path
		end
	end
end