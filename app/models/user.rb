class User < ApplicationRecord
  	# Include default devise modules. Others available are:
  	# :confirmable, :lockable, :timeoutable and :omniauthable
  	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

    has_many :answers, dependent: :destroy

  	def next_image
  		uncompleted_images.first
	end

	def uncompleted_images
		images.select { |image| !image.completed_by_user?(self) }
	end

	def images
		Image.all.sort_by(&:id)
	end
end
