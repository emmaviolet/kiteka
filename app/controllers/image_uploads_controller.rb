class ImageUploadsController < AdminController

  def create
    params[:images]['file'].each do |a|
      @image = Image.create!(:path => a)
    end
    redirect_to admin_index_path
  end
end