# == Schema Information
#
# Table name: activities
#
#  id             :integer          not null, primary key
#  trackable_id   :integer
#  trackable_type :string
#  owner_id       :integer
#  owner_type     :string
#  key            :string
#  parameters     :text
#  recipient_id   :integer
#  recipient_type :string
#  created_at     :datetime
#  updated_at     :datetime
#

class Activity < PublicActivity::Activity

  acts_as_readable on: :created_at

  default_scope -> { order('created_at DESC') }

  scope :of_user, (lambda do |user|
    client_groups = user.client_groups_as_client
    where do
      (
        (recipient_type == 'User') &
        (recipient_id == user.id) &
        (owner_id != recipient_id)
      ) |
      (
        (recipient_type == 'ClientGroup') &
        (recipient_id >> client_groups.select { id })
      )
    end
  end)

  def mark_as_unread!(options = {})
    ReadMark.where(
      readable_type: self.class.base_class.name,
      readable_id: id,
      user_id: options[:for].id
    ).destroy_all
  end

end
