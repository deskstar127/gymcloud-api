# == Schema Information
#
# Table name: client_group_memberships
#
#  id              :integer          not null, primary key
#  client_group_id :integer
#  client_id       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class ClientGroupMembership < ActiveRecord::Base

  belongs_to :client_group
  belongs_to :client, class_name: User

  validates :client_group_id, :client_id, presence: true
  validates :client_id, uniqueness: {scope: :client_group_id}

end
