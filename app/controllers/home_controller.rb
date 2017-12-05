class HomeController < ApplicationController

	def index
		render nothing: true, status: :ok, content_type: "text/html"
	end
end