class IncreaseReadableTypeField < ActiveRecord::Migration
  def change
    change_column :read_marks, :readable_type, "varchar(255)"
  end
end
