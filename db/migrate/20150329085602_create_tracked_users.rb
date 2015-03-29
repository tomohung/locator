class CreateTrackedUsers < ActiveRecord::Migration
  def change
    create_table :tracked_users do |t|
      t.integer :user_id
      t.timestamps
    end
  end
end
