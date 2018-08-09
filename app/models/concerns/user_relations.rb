module UserRelations

  extend ActiveSupport::Concern

  included do

    has_one :user_profile,
      dependent: :destroy

    has_one :user_settings,
      dependent: :destroy

    has_many :certificates,
      dependent: :destroy

    has_many :authentications,
      class_name: 'UserAuthentication',
      dependent: :destroy

    has_many :agreements_as_pro,
      class_name: UserAgreement,
      foreign_key: :pro_id

    has_many :agreements_as_client,
      class_name: UserAgreement,
      foreign_key: :client_id

    has_many :pros,
      through: :agreements_as_client,
      class_name: User

    has_many :clients,
      through: :agreements_as_pro,
      class_name: User

    has_many :client_group_memberships,
      foreign_key: :client_id,
      dependent: :destroy

    has_many :client_groups,
      foreign_key: :pro_id,
      dependent: :destroy

    has_many :client_groups_as_client,
      through: :client_group_memberships,
      class_name: ClientGroup,
      source: :client_group

    has_many :exercises,
      foreign_key: :user_id,
      dependent: :nullify

    has_many :workout_templates,
      foreign_key: :user_id,
      dependent: :nullify

    has_many :personal_workouts,
      foreign_key: :person_id,
      dependent: :destroy

    has_many :program_templates,
      foreign_key: :user_id,
      dependent: :nullify

    has_many :personal_programs,
      foreign_key: :person_id,
      dependent: :destroy

    has_many :workout_events,
      through: :personal_workouts

    has_many :personal_properties,
      foreign_key: :person_id

    has_many :exercise_results,
      through: :workout_events,
      dependent: :destroy

    has_many :folders,
      dependent: :destroy

    has_many :videos,
      foreign_key: :author_id,
      dependent: :nullify

    has_many :exercises_as_author,
      class_name: Exercise,
      foreign_key: :author_id,
      dependent: :nullify

    has_many :program_templates_as_author,
      class_name: ProgramTemplate,
      foreign_key: :author_id,
      dependent: :nullify

    has_many :workout_templates_as_author,
      class_name: WorkoutTemplate,
      foreign_key: :author_id,
      dependent: :nullify

    has_many :request_pros,
      foreign_key: :client_id,
      dependent: :nullify

  end

end
