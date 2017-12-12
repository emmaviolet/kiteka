class User < ApplicationRecord
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :answers, dependent: :destroy

  	def next_image
  		image_queue.first
	end

	def image_queue
		available_images.select { |image| !image.completed_by_user?(self) }
	end

	def available_images
		images.reject(&:completed?)
	end

	def images
		Image.all.sort_by(&:id)
	end
end
