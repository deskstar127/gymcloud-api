class AddIsTrailingAndSubscriptionEndToUser < ActiveRecord::Migration
  def change
    add_column :users, :is_trialing, :boolean
    add_column :users, :subscription_end_at, :datetime
  end
end
