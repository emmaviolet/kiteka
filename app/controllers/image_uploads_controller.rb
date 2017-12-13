class ImageUploadsController < AdminController

	before_action :set_s3_direct_post, only: [:create]

  def create
  	Rails.logger.info("******** --> params ")
  	Rails.logger.info(params)

  	upload = params[:image_upload]
  	Rails.logger.info("******** --> upload ")
  	Rails.logger.info(upload)

  	images = upload[:images]
  	Rails.logger.info("******** --> images ")
  	Rails.logger.info(images)

  	avatars = images['avatar']
  	Rails.logger.info("******** --> avatar ")
  	Rails.logger.info(avatars)

  	avatars.each do |avatar|
  		if avatar.is_a? String
    		Rails.logger.info('AVATAR ******** --> ' + avatar)
      		@image = Image.create!(:path => avatar)
      	end
    end
    # params[:aws_path].each do |a|
    # 	Rails.logger.info('******** --> ' + a)
    #   @image = Image.create!(:path => a)
    # end
    redirect_to admin_index_path
  end
end