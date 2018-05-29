# frozen_string_literal: true

class ImagesController < ApplicationController
  def show
    @image = current_user.next_image
    render(:empty) && return unless @image

    @questions = @image.unanswered_questions_for_user(@current_user)
    @start_time = Time.now
  end
end
