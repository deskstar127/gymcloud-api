class Ability

  include CanCan::Ability

  def initialize(user)
    @user = user
    set_aliases
    rules_defaults
    apply_roles
  end

  private

  def set_aliases
    alias_action :index, :show, to: :read
    alias_action :new, to: :create
    alias_action :edit, to: :update
    alias_action :update, :destroy, to: :modify
    alias_action :create, :read, :update, :destroy, to: :crud
  end

  def rules_defaults
    cannot :manage, :all
  end

  def apply_roles
    as_anyone
    guest? && as_guest || as_user
    client? && as_client
    pro? && as_pro
    admin? && as_admin
  end

  def as_anyone
    as_explorer_can :read, Exercise
    as_explorer_can :read, WorkoutTemplate
    as_explorer_can :read, ProgramTemplate
  end

  def as_guest
  end

  def as_user
    can [:read, :create], User
    as_self_can [:read_email, :update_email], User
    as_self_can :update, User
    as_self_can [:manage_payments], User
    can :invite, User do |user|
      @user.agreements_as_client.where(pro: user).any?
    end
    can :create, RequestPro
    as_owner_can [:read, :destroy], UserAuthentication
    can :read, UserProfile
    as_owner_can :update, UserProfile
    as_owner_can [:create, :read, :update], UserSettings
    can [:create, :read, :destroy], Exercise, user_id: @user.id
    can [:create, :read, :destroy], WorkoutTemplate, user_id: @user.id
    can [:create, :read, :destroy], ProgramTemplate, user_id: @user.id
    as_author_can :crud, Exercise
    as_author_can :crud, WorkoutTemplate
    as_author_can :crud, ProgramTemplate
    can :read, PersonalWorkout, person_id: @user.id
    can :read, WorkoutExercise do |we|
      case we.workout_type
      when 'PersonalWorkout'
        we.workout.person_id == @user.id
      end
    end
    can :read, Exercise do |ex|
      ex.workout_exercises
        .joins { personal_workout }
        .where { personal_workout.person_id == my { @user.id } }
        .any?
    end
    can :read, PersonalProgram, person_id: @user.id
    can :crud, WorkoutEvent, personal_workout: {person_id: @user.id}
    can :crud, Activity do |notification|
      Activity.of_user(@user).where(id: notification.id).any?
    end
    can :crud, ExerciseResult do |exercise_result|
      exercise_result.person.id == @user.id
    end
    as_owner_can :crud, Comment
    can :read, Comment do |comment|
      case comment.commentable_type
      when 'WorkoutEventExercise'
        comment.commentable.workout_event.personal_workout.workout_template.user.id.in?(@user.pro_ids) &&
        comment.commentable.workout_event.person.id == @user.id
      end
    end
  end

  def as_client
  end

  def as_pro
    as_managing_pro_can :update, UserProfile, :user_id
    can :crud, ClientGroup, pro_id: @user.id
    can :crud, ClientGroupMembership, client_group: {pro_id: @user.id}
    can :crud, ProgramWorkout,
      program_id: @user.program_template_ids,
      program_type: 'ProgramTemplate',
      workout_id: @user.workout_template_ids,
      workout_type: 'WorkoutTemplate'
    can :crud, ProgramWorkout,
      program_id: @user.personal_program_ids,
      program_type: 'PersonalProgram',
      workout_id: @user.personal_workout_ids,
      workout_type: 'PersonalWorkout'
    can :crud, ProgramWorkout,
      program_id: PersonalProgram.where(person_id: @user.client_ids).pluck(:id),
      program_type: 'PersonalProgram',
      workout_id: PersonalWorkout.where(person_id: @user.client_ids).pluck(:id),
      workout_type: 'PersonalWorkout'
    can :read, ProgramWeek do |pw|
      case pw.program_type
      when 'ProgramTemplate'
        pw.program.user_id == @user.id
      end
    end
    can :crud, ProgramWeek do |pw|
      case pw.program_type
      when 'ProgramTemplate'
        pw.program.author_id == @user.id
      when 'PersonalProgram'
        pw.program.person_id.in?(@user.client_ids)
      end
    end
    as_managing_pro_can :create, PersonalWorkout, :person_id,
      workout_template_id: @user.workout_template_ids
    as_managing_pro_can [:read, :update, :disable], PersonalWorkout, :person_id
    as_managing_pro_can :create, PersonalProgram, :person_id,
      program_template_id: @user.program_template_ids
    as_managing_pro_can [:read, :update, :disable], PersonalProgram, :person_id
    can :crud, WorkoutEvent,
      personal_workout: {person_id: @user.client_ids}
    # NOTE: Figure out with this stuff
    # if_new_can :read, WorkoutEvent
    can :crud, Folder
    can [:read, :update], PersonalProperty
    can :invite, User do |user|
      user.agreements_as_client.where(pro: @user).any?
    end
    can :crud, ExerciseResult do |exercise_result|
      exercise_result.person.id.in?(@user.client_ids)
    end
    can :read, Comment do |comment|
      case comment.commentable_type
      when 'WorkoutEventExercise'
        comment.commentable.workout_event.person.id.in?(@user.client_ids) &&
        comment.commentable.workout_event.personal_workout.workout_template.user.id == @user.id
      end
    end
    can :read, WorkoutExercise do |we|
      case we.workout_type
      when 'WorkoutTemplate'
        we.workout.user_id == @user.id
      end
    end
    can :crud, WorkoutExercise do |we|
      case we.workout_type
      when 'WorkoutTemplate'
        we.workout.author_id == @user.id
      when 'PersonalWorkout'
        we.workout.person_id.in?(@user.client_ids)
      end
    end
    can :crud, ExerciseProperty, personal_property: {person_id: @user.id}
    can :import, ProgramPreset
    can :upload, Certificate
  end

  def as_admin
    can :manage, :all
  end

  def guest?
    false
  end

  def client?
    false
  end

  def pro?
    @user.pro?
  end

  def admin?
    false
  end

  def as_self_can(action, object)
    can action, object, id: @user.id
  end

  def as_owner_can(action, object)
    can action, object, user_id: @user.id
  end

  def as_author_can(action, object)
    can action, object, author_id: @user.id
  end

  def as_explorer_can(action, object)
    can action, object, is_public: true
  end

  def as_managing_pro_can(action, object, attr, attrs = {})
    attrs.merge!(
      attr => @user.client_ids
    )
    can action, object, attrs
  end

  def if_new_can(action, object)
    can action, object do |instance|
      instance.new_record?
    end
  end

end
