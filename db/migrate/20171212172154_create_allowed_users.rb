class CreateAllowedUsers < ActiveRecord::Migration[5.1]
  def change
    create_table :allowed_users, id: :uuid do |t|
    	t.string :email
    end
  end
end
