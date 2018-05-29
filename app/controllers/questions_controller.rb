# frozen_string_literal: true

class QuestionsController < AdminController
  def create
    attributes = params[:question]
    question_attributes = attributes.permit(:text)
    Question.create!(question_attributes)

    redirect_to questions_path
  end

  # because delete method does not work
  def show
    question = Question.find(params[:id])
    question.delete

    redirect_to questions_path
  end
end
