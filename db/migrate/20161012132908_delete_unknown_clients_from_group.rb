class DeleteUnknownClientsFromGroup < ActiveRecord::Migration
  def up
    ::User.pros.each do |pro|
      pro.client_groups.each do |group|
        group.client_ids = (pro.client_ids & group.client_ids)
      end
    end
  end
end
