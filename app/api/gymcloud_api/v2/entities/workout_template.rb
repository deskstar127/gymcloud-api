module GymcloudAPI::V2
module Entities

class WorkoutTemplate < Grape::Entity

  expose :id
  expose :created_at
  expose :updated_at
  expose :name
  expose :description
  expose :note
  expose :video_url
  expose :video_id
  expose :is_public
  expose :is_visible
  expose :user_id
  expose :author_id
  expose :author_full_name do |template|
    template.author.user_profile.full_name
  end
  expose :folder_id
  expose :version do |template|
    template.versions.count
  end
  expose :workout_exercises,
    if: {nested: true},
    using: Entities::WorkoutExercise,
    as: :exercises
  expose :assignees,
    if: {nested: true},
    using: Entities::WorkoutAssignees \
  do |template|
    ::PersonalWorkout
      .where(workout_template_id: template.id)
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
