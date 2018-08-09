module GymcloudAPI::V2
module Namespaces

class WorkoutEvents < Base

helpers do

  def send_results_email(event)
    # The only case to send email is when client added result
    return false if current_user.pro?
    user_id = event.person.pros.first.id
    changes = event.changes[:is_completed]
    if !changes[0] && changes[1]
      HtmlMailer.delay.results_added(user_id, event.id)
    end
  end

  def send_event_email(event)
    mailer_method = if (event.begins_at - Time.now) / 1.hours > 1
                      delayed_time = event.begins_at - 1.hours
                      HtmlMailer.delay_until(delayed_time)
                    else
                      HtmlMailer.delay
                    end
    unless event.personal_workout.person.pro?
      if current_user.pro?
        user_id = event.person.id
        creator_id = event.person.pros.first.id
      else
        user_id = event.person.pros.first.id
        creator_id = event.person.id
      end
      mailer_method.event_scheduled(
        user_id,
        creator_id,
        event.id
      )
    end
  end
end

namespace :workout_events do

  desc 'Create Workout Event'
  params do
    requires :personal_workout_id, type: Integer
    requires :begins_at, type: DateTime
    optional :ends_at, type: DateTime
    optional :is_completed, type: Boolean, default: 'false'
  end
  post do
    event = ::WorkoutEvent.new(filtered_params)
    authorize!(:create, event)
    event.save!
    send_event_email(event)
    recipient =
      if current_user.pro?
        event.person
      else
        event.personal_workout.workout_template.user
      end
    event.create_activity(
      action: :create,
      owner: current_user,
      recipient: recipient
    )

    event.personal_workout.workout_exercises.each do |exercise|
      ::WorkoutEventExercise.create!(
        workout_event: event,
        workout_exercise: exercise
      )
    end

    present(event, with: Entities::WorkoutEvent)
  end

  params do
    requires :id, type: Integer, desc: 'Workout Event ID'
  end
  route_param :id do

    desc 'Read Workout Event'
    get do
      event = ::WorkoutEvent.find(params[:id])
      authorize!(:read, event)
      present(event, with: Entities::WorkoutEvent)
    end

    desc 'Update Workout Event'
    params do
      optional :begins_at, type: DateTime
      optional :ends_at, type: DateTime
      optional :is_completed, type: Boolean
    end
    patch do
      event = ::WorkoutEvent.find(params[:id])
      event.assign_attributes(filtered_params)
      authorize!(:update, event)
      send_results_email(event)
      event.save!
      present(event, with: Entities::WorkoutEvent)
    end

    desc 'Delete Workout Event'
    delete do
      event = ::WorkoutEvent.find(params[:id])
      authorize!(:destroy, event)
      event.destroy
      present(event, with: Entities::WorkoutEvent)
    end

    desc 'Fetch full Event content'
    get :full do
      event = ::WorkoutEvent.find(params[:id])
      authorize!(:read, event)
      present(event, with: Entities::WorkoutEventFull, expose_previous: true)
    end

  end

end

end

end
end
