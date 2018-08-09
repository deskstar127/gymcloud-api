# == Schema Information
#
# Table name: certificates
#
#  id         :integer          not null, primary key
#  user_id    :integer
#  status     :integer          default(0)
#  file       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Certificate < ActiveRecord::Base

  mount_uploader :file, CertificateUploader

  belongs_to :user

  enum status: [:unverified, :verified, :declined]

  validates :status, :file, :user_id, presence: true

end
