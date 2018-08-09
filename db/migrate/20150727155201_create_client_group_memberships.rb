class CreateClientGroupMemberships < ActiveRecord::Migration
  def change
    create_table :client_group_memberships do |t|
      t.integer :client_group_id
      t.integer :client_id

      t.timestamps null: false
    end
  end
end
