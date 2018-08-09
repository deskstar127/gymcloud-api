class AddUserIdToEwp < ActiveRecord::Migration
  def up
    %i(exercises workout_templates program_templates).each do |table|
      add_column table, :user_id, :integer
      add_index table, :user_id

      add_column table, :original_id, :integer
      add_index table, :original_id

      execute("update #{table} set user_id = author_id")
    end
  end

  def down
    %i(exercises workout_templates program_templates).each do |table|
      remove_column table, :user_id, :email
      remove_column table, :original_id, :email
    end
  end

end
