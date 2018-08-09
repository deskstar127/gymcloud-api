# == Schema Information
#
# Table name: property_units
#
#  id         :integer          not null, primary key
#  short_name :string
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class PropertyUnit < ActiveRecord::Base

  has_and_belongs_to_many :global_property

  validates :name, :short_name, presence: true
  validates :short_name, uniqueness: true
  validates :name, :short_name, length: {maximum: 255}

  default_scope -> { order(id: :asc) }

end
