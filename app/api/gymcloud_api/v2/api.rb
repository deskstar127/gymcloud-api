module GymcloudAPI
module V2

class API < Grape::API

  include APIGuard

  version 'v2', using: :header, vendor: 'gymcloud'

  helpers GlobalHelpers

  guard_all!

  default_format :json

  mount Namespaces::Root
  mount Namespaces::Cards
  mount Namespaces::Certificates
  mount Namespaces::ClientGroups
  mount Namespaces::Clients
  mount Namespaces::ClientsPerformance
  mount Namespaces::Comments
  mount Namespaces::Dashboards
  mount Namespaces::ExerciseProperties
  mount Namespaces::ExerciseResults
  mount Namespaces::Exercises
  mount Namespaces::Folders
  mount Namespaces::Notifications
  mount Namespaces::PersonalPrograms
  mount Namespaces::PersonalProperties
  mount Namespaces::PersonalWorkouts
  mount Namespaces::ProgramPresets
  mount Namespaces::ProgramTemplates
  mount Namespaces::ProgramWeeks
  mount Namespaces::ProgramWorkouts
  mount Namespaces::Pros
  mount Namespaces::Search
  mount Namespaces::Subscriptions
  mount Namespaces::UserAccountTypes
  mount Namespaces::UserAuthentications
  mount Namespaces::UserProfiles
  mount Namespaces::UserSettings
  mount Namespaces::Users
  mount Namespaces::Videos
  mount Namespaces::WorkoutEvents
  mount Namespaces::WorkoutExercises
  mount Namespaces::WorkoutTemplates

end

end
end
