class ImageUploadsController < AdminController

	before_action :set_s3_direct_post, only: [:create]

  def create
  	raise
    params[:images]['file'].each do |a|
      @image = Image.create!(:path => a)
    end
    redirect_to admin_index_path
  end
end