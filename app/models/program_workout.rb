# == Schema Information
#
# Table name: program_workouts
#
#  id           :integer          not null, primary key
#  workout_id   :integer
#  workout_type :string
#  program_id   :integer
#  program_type :string
#  note         :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  position     :integer
#  week_id      :integer
#  source_id    :integer
#  source_type  :string
#

class ProgramWorkout < ActiveRecord::Base

  include HasTemplateVersion
  include Cloneable

  belongs_to :workout,
    -> { with_deleted },
    polymorphic: true,
    dependent: :destroy
  belongs_to :program, -> { with_deleted }, polymorphic: true
  belongs_to :week, class_name: 'ProgramWeek'

  validates :workout_id, :program_id, presence: true
  validates :workout_type,
    inclusion: {in: %w(WorkoutTemplate PersonalWorkout)}
  validates :program_type,
    inclusion: {in: %w(ProgramTemplate PersonalProgram)}

  scope :without_week, -> { where(week_id: nil) }

  def display_name
    workout.name
  end

end
