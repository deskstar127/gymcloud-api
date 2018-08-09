class CreateRequestPros < ActiveRecord::Migration
  def change
    create_table :request_pros do |t|
      t.integer :client_id
      t.boolean :pro_provided

      t.timestamps null: false
    end
  end
end
