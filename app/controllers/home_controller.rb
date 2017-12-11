class HomeController < ApplicationController

	def show
		@image = Image.first
		@question = Question.first
	end
end