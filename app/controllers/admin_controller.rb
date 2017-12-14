require 'csv'

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

	def download_data
		@csv_string = CSV.generate do |csv|
			csv << ['image', 'question', 'user', 'response', 'start_time', 'submit_time']

			Answer.all.sort_by(&:submit_time).each do |answer|
				image = answer.image.path.split('/').last
				question = answer.question.text
				user = answer.user.email
				response = answer.response
				start_time = answer.start_time
				submit_time = answer.submit_time
				csv << [image, question, user, response, start_time, submit_time]
			end
		end

		send_file(@csv_string)
	end

	def set_s3_direct_post
   		@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
  	end
end