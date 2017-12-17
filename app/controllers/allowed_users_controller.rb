class AllowedUsersController < AdminController

	def create
		attributes = params[:allowed_user]
		user_attributes = attributes.permit(:email)

		AllowedUser.create!(email: user_attributes[:email].downcase)

		redirect_to admin_index_path
	end

	def destroy
		allowed_user = AllowedUser.find(params[:id])
		allowed_user.delete

		redirect_to admin_index_path
	end
end