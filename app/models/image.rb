class Image < ApplicationRecord
	has_many :answers, dependent: :destroy
	mount_uploader :path, AvatarUploader

	def mark_if_completed
		users_completed = users.select { |user| self.completed_by_user?(user) }
		self.completed = users_completed.count > 1
	end

	def completed_by_user?(user)
		!next_question_for_user(user)
	end

	def next_question_for_user(user)
		unanswered_questions_for_user(user).first
	end

	def unanswered_questions_for_user(user)
		questions.select do |question|
			question_answers = self.answers.where(user_id: user.id, question_id: question.id)
			question_answers.empty?
		end
	end

	def last_question
		questions.last
	end

	def questions
		Question.all.sort_by(&:id)
	end

	def users
		User.all.sort_by(&:id)
	end
end