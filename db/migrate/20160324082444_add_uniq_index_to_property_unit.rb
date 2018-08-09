class AddUniqIndexToPropertyUnit < ActiveRecord::Migration
  def change
    add_index :property_units, :short_name, unique: true
  end
end
