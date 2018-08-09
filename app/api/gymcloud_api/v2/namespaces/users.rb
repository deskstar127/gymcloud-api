module GymcloudAPI::V2
module Namespaces

class Users < Base

namespace :users do

  desc 'Fetch Current User' do
    success Entities::User
  end
  get :me do
    authorize!(:read, current_user)
    present current_user,
      with: Entities::User,
      email: true
  end

  params do
    requires :id, type: Integer, desc: 'User ID'
  end
  route_param :id do

    desc 'Fetch User' do
      success Entities::User
    end
    get do
      user = ::User.find(params[:id])
      authorize!(:read, user)
      present user,
        with: Entities::User,
        email: current_user.can?(:read_email, user)
    end

    desc 'Update User' do
      success Entities::User
    end
    params do
      optional :email, type: String, regexp: /.+@.+/
    end
    patch do
      user = ::User.find(params[:id])
      user.assign_attributes(filtered_params)
      authorize!(:update, user)
      user.save!
      present user,
        with: Entities::User,
        email: current_user.can?(:read_email, user)
    end

    desc 'Invite User' do
      success Entities::User
    end
    params do
      optional :email, type: String, regexp: /.+@.+/
    end
    post :invite do
      user = ::User.find(params[:id])
      authorize!(:invite, user)
      Services::Clients::Invite.!(
        current_user: current_user,
        user: user,
        email: params[:email]&.downcase&.squish
      )
      present(user, with: Entities::User)
    end

    desc 'Stripe Customer'
    get :customer do
      user = ::User.find(params[:id])
      authorize!(:manage_payments, user)
      customer = Services::Stripe::GetCustomer.!(user: user)
      present(customer)
    end

    desc 'User Subscription'
    get :subscription do
      user = ::User.find(params[:id])
      authorize!(:manage_payments, user)
      subscription = Services::Stripe::CheckUserSubscription.!(user: user)
      present(subscription)
    end

    namespace :collections do

      namespace :user_authentications do
        desc 'Fetch Authentications'
        get do
          user = ::User.find(params[:id])
          authentications = user.authentications
          authorize!(:read, authentications.build)
          authentications.reset
          present(authentications, with: Entities::UserAuthentication)
        end
      end

      %i(
        pros client_groups
        exercises program_templates
        personal_properties
        folders
      ).each do |collection|
        namespace collection do
          desc "Fetch #{collection.to_s.titleize}"
          get do
            user = ::User.find(params[:id])
            result = user.send(collection)
            authorize!(:read, result.build)
            result.reset
            klass = user.association(collection).klass
            entity = "GymcloudAPI::V2::Entities::#{klass.name}".constantize
            present(result, with: entity)
          end
        end
      end

      namespace :clients do
        desc 'Fetch Clients'
        get do
          user = ::User.find(params[:id])
          result = user.clients
          authorize!(:read, result.build)
          result.reset
          entity = GymcloudAPI::V2::Entities::User
          present(result, with: entity, email: true)
        end
      end

      resource :workout_templates do
        desc 'Fetch Workout Templates'
        get do
          user = ::User.find(params[:id])
          workout_templates = user.workout_templates.is_visible
          authorize!(:read, workout_templates.build)
          workout_templates.reset
          present(workout_templates, with: Entities::WorkoutTemplate)
        end
      end

      %i(
        personal_workouts personal_programs
      ).each do |collection|
        namespace collection do
          desc "Fetch #{collection.to_s.titleize}"
          params do
            optional :status, type: String,
              values: %w(inactive active all),
              default: 'active',
              desc: "Status of #{collection.to_s.titleize}"
          end
          get do
            scope = {
              active: :is_active,
              inactive: :is_inactive,
              all: :unscoped
            }[params[:status]] || :is_active
            user = ::User.find(params[:id])
            result = user.send(collection).send(scope)
            authorize!(:read, result.build)
            result.reset
            klass = user.association(collection).klass
            entity = "GymcloudAPI::V2::Entities::#{klass.name}".constantize
            present(result, with: entity)
          end
        end
      end

      resource :personal_exercises do
        desc 'Fetch assigned user exercises'
        get do
          user = ::User.find(params[:id])
          exercises = ::Exercise.personal_for(user)
          authorize!(:update, user.user_profile)
          present exercises,
            with: Entities::Exercise,
            nested: false
        end
      end

      resource :workout_exercises do
        desc 'Fetch user workout exercises'
        get do
          user = ::User.find(params[:id])
          workout_exercises = ::WorkoutExercise.personal_for(user)
          workout_exercise = workout_exercises.build(
            workout: ::PersonalWorkout.new(person: user)
          )
          authorize!(:read, workout_exercise)
          present workout_exercises,
            with: Entities::WorkoutExercise,
            nested: false
        end
      end

      resource :workout_events do
        desc 'Fetch user workout events'
        params do
          optional :scope, type: String,
            values: %w(all upcoming past all_with_clients),
            default: 'all',
            desc: 'Scope of events'
          optional :range_from, type: DateTime
          optional :range_to, type: DateTime
        end
        paginate per_page: 50, max_per_page: 50
        get do
          user = ::User.find(params[:id])
          scope = params[:scope]
          from = params[:range_from]
          to = params[:range_to]
          workout_events = user.workout_events
          if from.present? && to.present?
            if scope == 'all'
              workout_events = workout_events.in_range(from, to)
            elsif scope == 'all_with_clients'
              workout_events = ::WorkoutEvent
                .with_clients(user)
                .in_range(from, to)
            end
          else
            workout_events = workout_events.send(scope)
          end
          workout_event = workout_events.build(
            personal_workout: ::PersonalWorkout.new(
              person: user
            )
          )
          authorize!(:read, workout_event)
          present(paginate(workout_events), with: Entities::WorkoutEvent)
        end
      end

      resource :library do
        desc 'Fetch user library'
        get do
          user = ::User.find(params[:id])
          authorize!(:update, user)
          library = user.library
          present(library)
        end
      end

      resource :notifications do

        desc 'Fetch user notifications'
        paginate per_page: 50, max_per_page: 50
        get do
          user = ::User.find(params[:id])
          authorize!(:read, user)
          notifications = Activity.of_user(user)
          present(paginate(notifications), with: Entities::Notification)
        end

        desc 'Mark all Notifications as Read'
        patch :read_all do
          user = ::User.find(params[:id])
          authorize!(:update, user)

          notifications = ::Activity.of_user(user).unread_by(user)

          ::Activity.transaction do
            notifications.each { |item| item.mark_as_read!(for: user) }
          end

          status :no_content
        end

      end

      resource :transactions do
        desc 'Fetch user transactions'
        params do
          optional :starting_after, type: String
        end
        get do
          user = ::User.find(params[:id])
          authorize!(:manage_payments, user)
          transactions = Services::Stripe::GetTransactionsList.!(
            user: user,
            starting_after: params[:starting_after]
          )
          present(transactions)
        end
      end

    end

  end

end

end

end
end
