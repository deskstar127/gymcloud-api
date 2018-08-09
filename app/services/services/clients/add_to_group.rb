module Services
module Clients

class AddToGroup < BaseService

  def run
    add_to_group
  end

  def input_params
    [:client_id, :group_id, :assign_templates]
  end

  def defaults
    {assign_templates: true}
  end

  def add_to_group
    membership = build
    membership.save!
    assign_templates(membership.client) if @assign_templates
    membership.client_group
  end

  def build
    client_group = ::ClientGroup.find(@group_id)
    user = ::User.find(@client_id)
    ClientGroupMembership.new(
      client_group: client_group,
      client: user
    )
  end

  private

  def assign_templates(client)
    templates = ::WorkoutTemplate.where(client_group_id: @group_id)
    templates.each do |template|
      create_personal(template, client)
    end
  end

  def create_personal(template, user)
    return if already_assigned?(template, user.id)
    workout = Services::PersonalAssignment::Workout.!(
      template: template,
      user: user
    )
    create_activity_for(workout, template.user)
    workout
  end

  def already_assigned?(template, user_id)
    ::PersonalWorkout
      .assigned_by(template.user)
      .exists?(
        workout_template: template.original || template,
        person_id: user_id
      )
  end

  def create_activity_for(workout, owner)
    workout.create_activity(
      action: :create,
      owner: owner,
      recipient: workout.person
    )
  end

end

end
end
