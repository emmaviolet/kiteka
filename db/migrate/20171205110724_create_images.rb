class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images, id: :uuid do |t|
    	t.string :path
    	t.boolean :completed
    end
  end
end
