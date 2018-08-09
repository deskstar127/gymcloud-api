class CreateCertificates < ActiveRecord::Migration
  def change
    create_table :certificates do |t|
      t.references :user, index: true, foreign_key: true
      t.integer :status, default: 0
      t.string :file

      t.timestamps null: false
    end
  end
end
