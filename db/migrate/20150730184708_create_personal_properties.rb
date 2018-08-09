class CreatePersonalProperties < ActiveRecord::Migration
  def change
    create_table :personal_properties do |t|
      t.references :global_property, index: true, foreign_key: true
      t.integer :position
      t.boolean :is_visible
      t.integer :person_id

      t.timestamps null: false
    end
  end
end
