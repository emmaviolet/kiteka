class CreateImages < ActiveRecord::Migration[5.1]
  def change
    create_table :images, id: :uuid do |t|
    	t.string :path
    end
  end
end
