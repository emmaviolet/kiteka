class ImagesController < ApplicationController

	def show
		@image = current_user.next_image
		render :empty and return if !@image

		Rails.logger.info("IMAGE")
		Rails.logger.info(@image)
		Rails.logger.info(@image.path)

		@questions = @image.unanswered_questions_for_user(@current_user)
		@start_time = Time.now
	end
end