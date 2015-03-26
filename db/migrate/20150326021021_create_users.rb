class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :device_token
      t.string :username
      t.integer :gravatar_id
      t.string :device_os
      t.string :device_os_version
      t.timestamps
    end
  end
end
