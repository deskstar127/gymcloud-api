class CreateJoinTableProgramPresetProgramTemplate < ActiveRecord::Migration
  def change
    create_join_table :program_presets, :program_templates do |t|
      # t.index [:program_preset_id, :program_template_id]
      # t.index [:program_template_id, :program_preset_id]
    end
  end
end
