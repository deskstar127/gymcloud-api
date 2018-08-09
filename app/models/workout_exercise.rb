# == Schema Information
#
# Table name: workout_exercises
#
#  id               :integer          not null, primary key
#  exercise_id      :integer
#  workout_id       :integer
#  note             :text
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  exercise_version :integer
#  workout_type     :string
#  order_name       :string
#  position         :integer
#  source_id        :integer
#  source_type      :string
#

class WorkoutExercise < ActiveRecord::Base

  include HasTemplateVersion
  include Cloneable

  belongs_to :exercise, -> { with_deleted }
  belongs_to :workout, -> { with_deleted }, polymorphic: true
  belongs_to :personal_workout,
    -> { where(workout_exercises: {workout_type: 'PersonalWorkout'}) },
    foreign_key: 'workout_id'
  has_many :exercise_properties,
    dependent: :destroy
  has_many :exercise_results,
    dependent: :destroy
  has_many :workout_event_exercises,
    dependent: :destroy

  validates :exercise_id, :workout_id, presence: true
  validates :workout_type,
    inclusion: {in: %w(WorkoutTemplate PersonalWorkout)}

  scope :personal_for, (lambda do |user|
    active_status = ::PersonalWorkout.statuses[:active]
    joins { personal_workout }
    .where { personal_workouts.person_id == my { user.id } }
    .where { personal_workouts.status == my { active_status } }
  end)

  has_template_version :exercise

  def display_name
    source_exercise.name
  end

end
