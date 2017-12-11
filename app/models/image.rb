class Image < ApplicationRecord
	has_many :answers, dependent: :destroy

	def completed?
		# have two users answered all questions
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
			completed_answer = question_answers.map(&:response).reject(&:blank?).any?

			question_answers.empty? || !completed_answer
		end
	end

	def questions
		Question.all.sort_by(&:id)
	end
end