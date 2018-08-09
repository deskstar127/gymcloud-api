# == Schema Information
#
# Table name: exercise_results
#
#  id                  :integer          not null, primary key
#  workout_event_id    :integer
#  workout_exercise_id :integer
#  is_personal_best    :boolean
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#

class ExerciseResult < ActiveRecord::Base

  include PublicActivity::Common

  belongs_to :workout_event
  belongs_to :workout_exercise
  has_many :exercise_result_items, dependent: :destroy
  has_one :person, through: :workout_event

  validates :workout_exercise_id, :workout_event_id, presence: true
  validate :check_exercise_workout_type

  scope :personal_best_for, (lambda do |exercise_id, user_id|
    joins { workout_exercise }
    .joins { workout_exercise.exercise }
    .joins { workout_event }
    .joins { workout_event.personal_workout }
    .where { workout_exercise.exercise.id == my { exercise_id } }
    .where { workout_event.personal_workout.person_id == my { user_id } }
    .where { is_personal_best == true }
  end)

  def display_name
    "#{workout_exercise.display_name} - #{workout_event.display_name}"
  end

  private

  def check_exercise_workout_type
    return if workout_exercise&.workout_type == 'PersonalWorkout'
    errors.add(:workout_exercise, 'PersonalWorkout only allowed')
  end

end
