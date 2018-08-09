class TrimUserEmails < ActiveRecord::Migration
  def up
    execute("UPDATE users SET email = LOWER(TRIM(email))")
  end
end
