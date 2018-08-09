class AddUniquenessIndexToClientGroupMembership < ActiveRecord::Migration
  def change
    add_index :client_group_memberships, [:client_id, :client_group_id], unique: true
  end
end
