module Services
module GroupAssignment

class Workout < BaseService

  def run
    create_personal_workouts
  end

  def input_params
    [:template, :group, :pro, :create_activities]
  end

  def defaults
    {create_activities: false}
  end

  def build_personal
    service = Services::PersonalAssignment::Workout.new(
      template: @template,
      user: @group.clients.first
    )
    service.build_personal
  end

  private

  def template_duplicate
    template = Services::TemplateDuplicating::Workout.!(
      workout: @template,
      user: @template.user,
      is_visible: false
    )
    template.client_group = @group
    template.save!
    template
  end

  def create_personal_workouts
    ids = assigned_client_ids
    users = @group.clients.where { id << ids }
    group_template = template_duplicate
    users.map { |user| create_personal(user, group_template) }
  end

  def create_personal(user, group_template)
    workout = Services::PersonalAssignment::Workout.!(
      template: group_template,
      user: user,
      is_default_for_group: true
    )
    create_activity_for(workout) if @create_activities
    workout
  end

  def assigned_client_ids
    ::PersonalWorkout
      .assigned_by(@pro)
      .where(workout_template: @template)
      .pluck(:person_id)
      .to_a
  end

  def create_activity_for(workout)
    workout.create_activity(
      action: :create,
      owner: @pro,
      recipient: workout.person
    )
  end

end

end
end
