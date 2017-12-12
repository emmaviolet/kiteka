class AnswersController < ApplicationController

	def create
		attributes = params.permit(:image_id, :question_id, :start_time, :response)
		attributes.merge!(user_id: current_user.id, submit_time: Time.now)
		Answer.create!(attributes)

		redirect_to root_url
	end
end