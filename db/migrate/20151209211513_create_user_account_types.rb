class CreateUserAccountTypes < ActiveRecord::Migration
  def change
    create_table :user_account_types do |t|
      t.string :name
      t.string :icon

      t.timestamps null: false
    end
  end
end
