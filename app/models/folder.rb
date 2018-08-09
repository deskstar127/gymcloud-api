# == Schema Information
#
# Table name: folders
#
#  id         :integer          not null, primary key
#  name       :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :integer
#

class Folder < ActiveRecord::Base

  has_closure_tree

  belongs_to :user
  has_many :exercises, dependent: :nullify
  has_many :workout_templates, -> { is_visible }, dependent: :nullify
  has_many :program_templates, dependent: :nullify

  validates :name, :user_id, presence: true
  validates :name, length: {maximum: 255}

  validate :only_one_root_per_user

  def items
    exercises.presence ||
      workout_templates.presence ||
      program_templates.presence ||
      []
  end

  def destroy
    ActiveRecord::Base.transaction do
      destroy_descendant_folders
      super
    end
  end

  def destroy_with_items
    ActiveRecord::Base.transaction do
      items.each(&:destroy)
      destroy_descendant_folders_with_items
      destroy
    end
  end

  private

  def destroy_descendant_folders
    descendants.reverse_each(&:destroy)
  end

  def destroy_descendant_folders_with_items
    descendants.reverse_each(&:destroy_with_items)
  end

  def only_one_root_per_user
    condition = name == 'Root' &&
      parent_id.nil? &&
      user_id.present? &&
      user.folders.where(name: 'Root').any?
    errors.add(:name, 'only one root folder is allowed') if condition
  end

end
