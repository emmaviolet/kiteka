class CreateQuestions < ActiveRecord::Migration[5.1]
  def change
    create_table :questions, id: :uuid do |t|
    	t.string :text
    end
  end
end
