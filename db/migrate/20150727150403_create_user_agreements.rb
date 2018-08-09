class CreateUserAgreements < ActiveRecord::Migration
  def change
    create_table :user_agreements do |t|
      t.integer :pro_id
      t.integer :client_id
      t.integer :category_id
      t.integer :status

      t.timestamps null: false
    end
  end
end
