# == Schema Information
#
# Table name: program_weeks
#
#  id           :integer          not null, primary key
#  name         :string
#  position     :integer
#  program_id   :integer
#  program_type :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  source_id    :integer
#  source_type  :string
#

class ProgramWeek < ActiveRecord::Base

  include Cloneable

  belongs_to :program, -> { with_deleted }, polymorphic: true

  has_many :program_workouts, dependent: :destroy, foreign_key: :week_id

  validates :name, :position, :program_id, presence: true
  validates :program_type,
    inclusion: {in: %w(ProgramTemplate PersonalProgram)}
  validates :name, length: {maximum: 255}

end
