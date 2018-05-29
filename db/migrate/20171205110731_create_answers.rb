# frozen_string_literal: true

class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers, id: :uuid do |t|
      t.datetime :start_time
      t.datetime :submit_time
      t.text :response

      t.belongs_to :question, type: :uuid, index: true
      t.belongs_to :image, type: :uuid, index: true
      t.belongs_to :user, type: :uuid, index: true
    end
  end
end
