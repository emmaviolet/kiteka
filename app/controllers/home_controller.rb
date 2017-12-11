class HomeController < ApplicationController

	def show
		@image = current_user.next_image
		if !@image
			# render some nice congratulations message
			return 
		end

		@question = @image.next_question_for_user(current_user)

		@answer = Answer.find_or_create_by!(
			image_id: @image.id, 
			question_id: @question.id, 
			user_id: current_user.id
		)

		@answer.start_time = Time.now
		@answer.save!
	end
end