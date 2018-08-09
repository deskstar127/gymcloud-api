# == Schema Information
#
# Table name: program_templates
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  note        :text
#  is_public   :boolean
#  author_id   :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  folder_id   :integer
#  deleted_at  :datetime
#  user_id     :integer
#  original_id :integer
#  weeks_count :integer
#

class ProgramTemplate < ActiveRecord::Base

  include SearchScopes::Training
  include DestroyedAuthor

  belongs_to :author, class_name: User
  belongs_to :user
  belongs_to :original, class_name: ProgramTemplate
  belongs_to :folder
  has_many :personal_programs
  has_many :program_workouts, as: :program
  has_many :program_weeks, as: :program
  has_many :duplicates,
    class_name: ProgramTemplate,
    foreign_key: :original_id,
    dependent: :nullify

  validates :name, :author_id, presence: true
  validates :is_public, inclusion: {in: [true, false]}
  validates :name, length: {maximum: 255}

  has_paper_trail
  acts_as_paranoid

  scope :assigned_to_group, (lambda do |client_group|
    ids = client_group.clients.pluck(:id).to_a
    active_status = ::PersonalProgram.statuses[:active]

    joins { personal_programs }
    .where { personal_programs.person_id >> my { ids } }
    .where { personal_programs.status == my { active_status } }
    .group { program_templates.id }
    .having { count(personal_programs.person_id) == my { ids.length } }
  end)

end
