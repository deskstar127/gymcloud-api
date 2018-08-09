# == Schema Information
#
# Table name: program_presets
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProgramPreset < ActiveRecord::Base

  belongs_to :user
  has_and_belongs_to_many :program_templates

  validates :name, :user_id, presence: true
  validates :name, length: {maximum: 255}

end
