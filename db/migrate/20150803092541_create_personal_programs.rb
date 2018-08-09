class CreatePersonalPrograms < ActiveRecord::Migration
  def change
    create_table :personal_programs do |t|
      t.string :name
      t.text :description
      t.text :note
      t.references :program_template, index: true, foreign_key: true
      t.integer :status
      t.integer :person_id

      t.timestamps null: false
    end

    add_index :personal_programs, :person_id
  end
end
