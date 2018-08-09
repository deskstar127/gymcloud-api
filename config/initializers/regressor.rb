# If the regressor gem is inside a group wrap your initializer in
if defined?(Regressor)

Regressor.configure do |config|

  # Defines the path where the generated files for your models will be placed
  config.regression_path = 'spec/models/regression'

  # Defines the path where the generated files for your controllers will be placed
  config.regression_controller_path = 'spec/controllers/regression'

  # Exclude Models for regression spec generation.
  # Provide model names as String (e.g. 'User')
  config.excluded_models = %w(
    Doorkeeper::AccessGrant
    Doorkeeper::AccessToken
    Doorkeeper::Application
  )

  # Exclude Controllers for regression generation.
  # Provide controller names as String (e.g. 'UsersController').
  config.excluded_controllers = %w(
    InheritedResources::Base
    DeviseController
    Devise::ConfirmationsController
    Devise::PasswordsController
    Devise::RegistrationsController
    Devise::SessionsController
    Devise::UnlocksController
    Devise::InvitationsController
    Devise::OmniauthCallbacksController
    ActiveAdmin::BaseController
    ActiveAdmin::Devise::ConfirmationsController
    ActiveAdmin::Devise::PasswordsController
    ActiveAdmin::Devise::RegistrationsController
    ActiveAdmin::Devise::SessionsController
    ActiveAdmin::Devise::UnlocksController
    ActiveAdmin::PageController
    ActiveAdmin::ResourceController
    OmniauthCallbacksController
    PreviewController
  )

  # If you are using enums in Rails 4 enable this option to generate regression specs for enums.
  # If your Rails version is =< Rails 3 set this option to false.
  # Default this option is set to true.
  config.include_enums = true

end

end
