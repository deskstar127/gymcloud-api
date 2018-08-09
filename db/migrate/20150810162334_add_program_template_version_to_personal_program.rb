class AddProgramTemplateVersionToPersonalProgram < ActiveRecord::Migration
  def change
    add_column :personal_programs, :program_template_version, :integer
  end
end
