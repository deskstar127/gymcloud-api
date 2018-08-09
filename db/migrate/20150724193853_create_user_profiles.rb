class CreateUserProfiles < ActiveRecord::Migration
  def change
    create_table :user_profiles do |t|
      t.integer :gender
      t.decimal :height
      t.decimal :weight
      t.decimal :bodyfat
      t.string :first_name
      t.string :last_name
      t.string :location
      t.string :zip
      t.string :employer
      t.date :birthday
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
