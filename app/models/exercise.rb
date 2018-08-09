# == Schema Information
#
# Table name: exercises
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  video_url   :string
#  is_public   :boolean
#  author_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  folder_id   :integer
#  deleted_at  :datetime
#  video_id    :integer
#  user_id     :integer
#  original_id :integer
#

class Exercise < ActiveRecord::Base

  include SearchScopes::Training
  include DestroyedAuthor

  belongs_to :author, class_name: User
  belongs_to :user
  belongs_to :original, class_name: Exercise
  belongs_to :folder
  belongs_to :video
  has_many :workout_exercises
  has_many :duplicates,
    class_name: Exercise,
    foreign_key: :original_id,
    dependent: :nullify

  validates :name, :author_id, presence: true
  validates :is_public, inclusion: {in: [true, false]}
  validates :name, :video_url, length: {maximum: 255}

  has_paper_trail
  acts_as_paranoid

  scope :personal_for, (lambda do |user|
    status = ::PersonalWorkout.statuses[:active]
    distinct
      .joins { workout_exercises }
      .joins { workout_exercises.personal_workout }
      .where { workout_exercises.personal_workouts.person_id == my { user.id } }
      .where { workout_exercises.personal_workouts.status == my { status } }
  end)

end
