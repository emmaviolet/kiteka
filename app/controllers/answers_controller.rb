class AnswersController < ApplicationController

	def update
		answer = Answer.find(params[:id])
		answer.response = params[:response]
		answer.submit_time = Time.now
		answer.save!

		redirect_to root_url
	end
end