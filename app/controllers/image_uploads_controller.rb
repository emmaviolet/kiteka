class ImageUploadsController < AdminController

	before_action :set_s3_direct_post, only: [:create]

  def create
  	images = params[:image_upload][:images]['avatar']
  	images.each do |avatar|
  		if avatar.is_a? String
    		Rails.logger.info('AVATAR ******** --> ' + avatar)
      		@image = Image.create!(:path => avatar)
      	end
    end
    redirect_to admin_index_path
  end
end