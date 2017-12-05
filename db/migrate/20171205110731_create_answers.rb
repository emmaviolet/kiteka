class CreateAnswers < ActiveRecord::Migration[5.1]
  def change
    create_table :answers, id: :uuid do |t|
    	t.datetime :start_time
    	t.datetime :submit_time

    	t.belongs_to :question, index: true
    	t.belongs_to :image, index: true
    	t.belongs_to :user, index: true
    end
  end
end
