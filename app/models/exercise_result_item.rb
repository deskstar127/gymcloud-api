# == Schema Information
#
# Table name: exercise_result_items
#
#  id                   :integer          not null, primary key
#  exercise_result_id   :integer
#  exercise_property_id :integer
#  value                :decimal(14, 5)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#

class ExerciseResultItem < ActiveRecord::Base

  belongs_to :exercise_result
  belongs_to :exercise_property

  validates :exercise_result_id, :exercise_property_id, :value, presence: true
  validates :value, numericality: {
    greater_than_or_equal_to: 0
  }

end
