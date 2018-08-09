# == Schema Information
#
# Table name: user_profiles
#
#  id         :integer          not null, primary key
#  gender     :integer
#  height     :decimal(, )
#  weight     :decimal(, )
#  bodyfat    :decimal(, )
#  first_name :string
#  last_name  :string
#  location   :string
#  zip        :string
#  employer   :string
#  birthday   :date
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  avatar     :string
#  timezone   :string
#

class UserProfile < ActiveRecord::Base

  mount_uploader :avatar, AvatarUploader

  belongs_to :user

  validates :first_name, :last_name, :location, :zip,
    :employer, length: {maximum: 255}

  scope :pros,
    -> { distinct.joins { user.agreements_as_pro } }
  scope :clients, (lambda do
    distinct
      .joins { user.agreements_as_client }
      .merge(UserAgreement.without_selftrained)
  end)

  enum gender: [:female, :male]

  def full_name
    [first_name, last_name].compact.join(' ')
  end

end
