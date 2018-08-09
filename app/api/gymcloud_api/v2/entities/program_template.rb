module GymcloudAPI::V2
module Entities

class ProgramTemplate < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :name
  expose :description
  expose :note
  expose :is_public
  expose :user_id
  expose :author_id
  expose :author_full_name do |template|
    template.author.user_profile.full_name
  end
  expose :folder_id
  expose :weeks_count
  expose :program_workouts,
    if: {nested: true},
    using: Entities::ProgramWorkout,
    as: :workouts
  expose :program_weeks,
    if: {nested: true},
    using: Entities::ProgramWeek,
    as: :weeks
  expose :assignees,
    if: {nested: true},
    using: Entities::ProgramAssignees \
  do |template|
    ::PersonalProgram
      .where(program_template_id: template.id)
      .assigned_by(template.user)
  end
  expose :group_assignments,
    if: {nested: true},
    using: Entities::ClientGroupAssignment \
  do |template|
    ::ClientGroup.where(pro: template.user).with_assinged_count_for(template)
  end

end

end
end
