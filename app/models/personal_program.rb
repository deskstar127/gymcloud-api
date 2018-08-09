# == Schema Information
#
# Table name: personal_programs
#
#  id                       :integer          not null, primary key
#  name                     :string
#  description              :text
#  note                     :text
#  program_template_id      :integer
#  status                   :integer
#  person_id                :integer
#  created_at               :datetime         not null
#  updated_at               :datetime         not null
#  program_template_version :integer
#  weeks_count              :integer
#

class PersonalProgram < ActiveRecord::Base

  include HasTemplateVersion
  include PublicActivity::Common

  belongs_to :program_template, -> { with_deleted }
  belongs_to :person, class_name: User
  has_one :author, through: :program_template
  has_one :user, through: :program_template
  has_many :program_workouts, as: :program, dependent: :destroy
  has_many :program_weeks, as: :program, dependent: :destroy

  validates :name, :program_template_id, :person_id, presence: true
  validates :name, length: {maximum: 255}

  enum status: [:inactive, :active]

  scope :is_active, -> { where(status: statuses[:active]) }
  scope :is_inactive, -> { where(status: statuses[:inactive]) }
  scope :assigned_by, (lambda do |user|
    where { person_id >> user.clients.pluck(:id) }
    .where { status == PersonalProgram.statuses[:active] }
  end)
  scope :with_deleted, -> {}

  has_template_version :program_template

end
