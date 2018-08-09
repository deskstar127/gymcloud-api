# == Schema Information
#
# Table name: exercise_properties
#
#  id                   :integer          not null, primary key
#  personal_property_id :integer
#  workout_exercise_id  :integer
#  value                :decimal(14, 5)
#  position             :integer
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  value2               :decimal(14, 5)
#  property_unit_id     :integer
#  source_id            :integer
#  source_type          :string
#

class ExerciseProperty < ActiveRecord::Base

  include Cloneable

  default_scope -> { order('id ASC') }

  belongs_to :personal_property
  belongs_to :workout_exercise
  belongs_to :property_unit
  has_many :exercise_result_items, dependent: :destroy

  validates :personal_property_id, :workout_exercise_id, presence: true

  def display_name
    prop = personal_property
    "#{prop.display_name} (#{value} #{prop.global_property.unit})"
  end

end
