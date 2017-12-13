class AdminController < ApplicationController
	before_action :authenticate_user_as_admin!
	before_action :set_s3_direct_post, only: [:index]

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

	def set_s3_direct_post
   		@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  	end
end