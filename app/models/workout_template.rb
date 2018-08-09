# == Schema Information
#
# Table name: workout_templates
#
#  id              :integer          not null, primary key
#  name            :string
#  description     :text
#  note            :text
#  video_url       :string
#  is_public       :boolean
#  author_id       :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  folder_id       :integer
#  is_visible      :boolean          default(TRUE)
#  deleted_at      :datetime
#  video_id        :integer
#  user_id         :integer
#  original_id     :integer
#  client_group_id :integer
#

class WorkoutTemplate < ActiveRecord::Base

  include SearchScopes::Training
  include DestroyedAuthor

  belongs_to :author, class_name: User
  belongs_to :user
  belongs_to :original, class_name: WorkoutTemplate
  belongs_to :folder
  belongs_to :video
  belongs_to :client_group
  has_many :personal_workouts
  has_many :workout_exercises, as: :workout, dependent: :destroy
  has_one :program_workout, as: :workout
  has_many :duplicates,
    class_name: WorkoutTemplate,
    foreign_key: :original_id,
    dependent: :nullify

  validates :name, :author_id, presence: true
  validates :is_public, inclusion: {in: [true, false]}
  validates :name, :video_url, length: {maximum: 255}

  has_paper_trail
  acts_as_paranoid

  scope :is_visible, -> { where(is_visible: :true, client_group_id: nil) }
  scope :is_invisible, -> { where(is_visible: :false) }
  scope :belongs_to_group, -> { where { client_group_id.not_eq nil } }

  scope :assigned_to_group, (lambda do |client_group|
    ids = client_group.clients.pluck(:id).to_a
    active_status = ::PersonalWorkout.statuses[:active]

    joins { personal_workouts }
    .where { personal_workouts.person_id >> my { ids } }
    .where { personal_workouts.status == my { active_status } }
    .group { workout_templates.id }
    .having { count(personal_workouts.person_id) == my { ids.length } }
  end)

end
