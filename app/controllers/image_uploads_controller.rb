class ImageUploadsController < AdminController

	before_action :set_s3_direct_post, only: [:create]

  def create
  	Rails.logger.info("******** --> ")
  	Rails.logger.info(params)
    # params[:aws_path].each do |a|
    # 	Rails.logger.info('******** --> ' + a)
    #   @image = Image.create!(:path => a)
    # end
    redirect_to admin_index_path
  end
end