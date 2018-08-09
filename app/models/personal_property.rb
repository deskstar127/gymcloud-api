# == Schema Information
#
# Table name: personal_properties
#
#  id                 :integer          not null, primary key
#  global_property_id :integer
#  position           :integer
#  is_visible         :boolean
#  person_id          :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class PersonalProperty < ActiveRecord::Base

  belongs_to :global_property
  belongs_to :person, class_name: User
  has_many :exercise_properties, dependent: :destroy
  has_many :property_units, through: :global_property
  has_one :default_unit, through: :global_property
  has_one :save_unit, through: :global_property

  validates :global_property_id, :person_id, presence: true

  def display_name
    global_property.name
  end

end
