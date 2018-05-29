# frozen_string_literal: true

require 'csv'

class AdminController < ApplicationController
  before_action :authenticate_user_as_admin!

  ADMIN_EMAILS = ['hephzi@kiteka.com', 'emmavioletmakinson@gmail.com', 'Liam@goddard.co.uk'].freeze

  def index
    @questions = Question.all
    @allowed_users = AllowedUser.all
  end

  def authenticate_user_as_admin!
    redirect_to root_path unless ADMIN_EMAILS.include?(current_user.email)
  end

  def download_data
    CSV.open('data.csv', 'w+') do |csv|
      csv << %w[image question user response start_time submit_time]

      Answer.all.sort_by(&:submit_time).each do |answer|
        image = answer.image.path.split('/').last
        question = answer.question.text
        user = answer.user.email
        response = answer.response
        start_time = answer.start_time
        submit_time = answer.submit_time
        csv << [image, question, user, response, start_time, submit_time]
      end
    end

    send_file('data.csv', filename: 'data.csv', type: 'text/csv; charset=iso-8859-1; header=present')
  end
end
