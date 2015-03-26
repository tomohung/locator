class CreateSignInRecords < ActiveRecord::Migration
  def change
    create_table :sign_in_records do |t|
      t.integer :user_id
      t.string :longitude
      t.string :latitude
      t.string :location_name
      t.text :comment
      t.string :photo_address
      t.timestamps
    end
  end
end
