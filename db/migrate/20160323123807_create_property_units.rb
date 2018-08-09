class CreatePropertyUnits < ActiveRecord::Migration
  def change
    create_table :property_units do |t|
      t.string :short_name
      t.string :name

      t.timestamps null: false
    end
  end
end
