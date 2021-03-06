class CreateAuthenticationProviders < ActiveRecord::Migration
  def change
    create_table :authentication_providers do |t|
      t.string :name

      t.timestamps null: false
    end
    add_index :authentication_providers, :name
    AuthenticationProvider.create(name: 'facebook')
    AuthenticationProvider.create(name: 'google_oauth2')
  end
end
