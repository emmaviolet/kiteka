class User < ApplicationRecord
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :answers, dependent: :destroy

  	def next_image
  		# get rid of image queue as it's quite work-intensive
  		# image_queue.first
  		available_images.find { |image| !image.completed_by_user?(self) }
	end

	# def image_queue
	# 	available_images.select { |image| !image.completed_by_user?(self) }
	# end

	def available_images
		images.reject { |image| image.completed }
	end

	def images
		Image.all
	end
end
