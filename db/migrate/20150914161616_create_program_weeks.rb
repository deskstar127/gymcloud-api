class CreateProgramWeeks < ActiveRecord::Migration
  def change
    create_table :program_weeks do |t|
      t.string :name
      t.integer :position
      t.references :program, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
