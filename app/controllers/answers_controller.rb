class AnswersController < ApplicationController

	def create
		attributes = params.permit(:image_id, :question_id, :start_time, :response)
		attributes.merge!(user_id: current_user.id, submit_time: Time.now)
		answer = Answer.create!(attributes)

		if answer.question == answer.image.last_question
			answer.image.mark_if_completed
			redirect_to root_path
		end
	end
end