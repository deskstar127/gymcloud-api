class CreateProgramTemplates < ActiveRecord::Migration
  def change
    create_table :program_templates do |t|
      t.string :name
      t.text :description
      t.text :note
      t.boolean :is_public
      t.integer :author_id

      t.timestamps null: false
    end

    add_index :program_templates, :author_id
  end
end
