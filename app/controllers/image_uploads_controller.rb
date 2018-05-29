# frozen_string_literal: true

class ImageUploadsController < AdminController
  def index
    s3_bucket_path = "http://#{ENV['S3_BUCKET']}.s3.amazonaws.com/"

    response = HTTParty.get(s3_bucket_path).parsed_response
    contents = response['ListBucketResult']['Contents']

    image_paths = contents.map { |content| s3_bucket_path + content['Key'] }

    image_paths.each do |image_path|
      Image.find_or_create_by(path: image_path)
    end

    redirect_to admin_index_path
  end
end
