class SetDefaultIsActiveToUsers < ActiveRecord::Migration

  def up
    User.update_all(is_active: true)
  end

  def down
  end

end
