class CreateUserAuthentications < ActiveRecord::Migration
  def change
    create_table :user_authentications do |t|
      t.references :user, index: true, foreign_key: true
      t.references :authentication_provider, index: true, foreign_key: true
      t.string :uid
      t.string :token
      t.datetime :token_expired_at
      t.text :params

      t.timestamps null: false
    end
  end
end
