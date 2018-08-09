class AddEmailRemoveTokenFromUserAuthentication < ActiveRecord::Migration
  def change
    remove_column :user_authentications, :token, :string
    remove_column :user_authentications, :token_expired_at, :datetime
    add_column :user_authentications, :email, :string
  end
end
