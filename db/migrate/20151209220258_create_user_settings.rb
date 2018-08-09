class CreateUserSettings < ActiveRecord::Migration
  def change
    create_table :user_settings do |t|
      t.integer :user_id
      t.references :user_account_type, index: true, foreign_key: true
      t.integer :units_system
      t.boolean :is_tutorial_finished
      t.boolean :is_presets_loaded

      t.timestamps null: false
    end
    add_index :user_settings, :user_id, unique: true
  end
end
