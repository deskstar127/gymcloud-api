module GymcloudAPI::V2
module Namespaces

class PersonalWorkouts < Base

namespace :personal_workouts do

  desc 'Create Personal Workout'
  params do
    requires :workout_template_id, type: Integer, desc: 'Workout Template ID'
    requires :person_id, type: Integer, desc: 'Assigned Person ID'
  end
  post do
    template = ::WorkoutTemplate.find(params[:workout_template_id])
    user = ::User.find(params[:person_id])
    service = Services::PersonalAssignment::Workout.new(
      template: template,
      user: user
    )
    authorize!(:create, service.build_personal)
    workout = service.process.result
    workout.create_activity(
      action: :create,
      owner: current_user,
      recipient: workout.person
    )
    unless current_user == user
      HtmlMailer.delay.workout_assigned(user.id, workout.id)
    end
    present(workout, with: Entities::PersonalWorkout)
  end

  params do
    requires :id, type: Integer, desc: 'Personal Workout ID'
  end
  route_param :id do

    desc 'Read Personal Workout'
    get do
      workout = ::PersonalWorkout.find(params[:id])
      authorize!(:read, workout)
      present(workout, with: Entities::PersonalWorkout, nested: true)
    end

    desc 'Update Personal Workout'
    params do
      optional :name, type: String
      optional :description, type: String
      optional :note, type: String
      optional :video_url, type: String
      optional :is_default_for_group, type: Boolean
    end
    patch do
      workout = ::PersonalWorkout.is_active.find(params[:id])
      workout.assign_attributes(filtered_params)
      authorize!(:update, workout)
      workout.save!
      present(workout, with: Entities::PersonalWorkout)
    end

    desc 'Disable Personal Workout'
    delete do
      workout = ::PersonalWorkout.is_active.find(params[:id])
      authorize!(:disable, workout)
      workout.update_attributes!(status: :inactive)
      present(workout, with: Entities::PersonalWorkout)
    end

    desc 'Fetch Personal Workout events'
    params do
      requires :user_id, type: Integer, desc: 'User ID'
      optional :scope, type: String,
        values: %w(all upcoming past all_with_clients),
        default: 'all',
        desc: 'Scope of events'
    end
    paginate per_page: 50, max_per_page: 50
    get :workout_events do
      user = ::User.find(params[:user_id])
      personal_workout = ::PersonalWorkout.find(params[:id])
      scope = params[:scope]
      workout_events = personal_workout.workout_events.send(scope)
      workout_event = workout_events.build(
        personal_workout: ::PersonalWorkout.new(
          person: user
        )
      )
      authorize!(:read, workout_event)
      present(paginate(workout_events), with: Entities::WorkoutEvent)
    end

  end

end

end

end
end
