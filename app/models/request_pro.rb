# == Schema Information
#
# Table name: request_pros
#
#  id           :integer          not null, primary key
#  client_id    :integer
#  pro_provided :boolean
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class RequestPro < ActiveRecord::Base

  belongs_to :client, class_name: User

  validates :client_id, presence: true
  validates :pro_provided, inclusion: {in: [true, false]}

end
