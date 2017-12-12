class Image < ApplicationRecord
	has_many :answers, dependent: :destroy

	def completed?
		# have two users completed all questions
		users_completed = users.select { |user| self.completed_by_user?(user) }
		users_completed.count > 1
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

			# completed answer shouldn't really be necessary any more but a useful check
			completed_answer = question_answers.map(&:response).reject(&:blank?).any?

			question_answers.empty? || !completed_answer
		end
	end

	def questions
		Question.all.sort_by(&:id)
	end

	def users
		User.all.sort_by(&:id)
	end
end