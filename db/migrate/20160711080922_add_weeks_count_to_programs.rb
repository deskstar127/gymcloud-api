class AddWeeksCountToPrograms < ActiveRecord::Migration
  def change
    add_column :program_templates, :weeks_count, :integer
    add_column :personal_programs, :weeks_count, :integer
  end
end
