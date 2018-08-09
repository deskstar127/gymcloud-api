class AddSourceToProgramWeek < ActiveRecord::Migration
  def change
    add_column :program_weeks, :source_id, :integer
    add_column :program_weeks, :source_type, :string
  end
end
