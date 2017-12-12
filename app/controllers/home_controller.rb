class HomeController < ApplicationController

	def show
		@image = current_user.next_image
		render :empty and return if !@image

		@question = @image.next_question_for_user(current_user)

		@start_time = Time.now
	end
end