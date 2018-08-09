class CreateClientGroups < ActiveRecord::Migration
  def change
    create_table :client_groups do |t|
      t.string :name
      t.integer :pro_id

      t.timestamps null: false
    end
  end
end
