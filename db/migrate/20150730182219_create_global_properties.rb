class CreateGlobalProperties < ActiveRecord::Migration
  def change
    create_table :global_properties do |t|
      t.string :symbol
      t.string :name
      t.string :unit

      t.timestamps null: false
    end

    add_index :global_properties, :symbol, unique: true
  end
end
