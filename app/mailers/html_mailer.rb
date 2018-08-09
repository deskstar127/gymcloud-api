class HtmlMailer < ApplicationMailer

  layout 'zurb'

  def welcome_new_user(user_id)
    @user = ::User.find(user_id)
    mail(to: @user.email, subject: "We're happy you're here!")
  end

  def program_assigned(user_id, program_id)
    @user = ::User.find(user_id)
    @program = ::PersonalProgram.find(program_id)
    mail(to: @user.email, subject: 'GymCloud')
  end

  def workout_assigned(user_id, workout_id)
    @user = ::User.find(user_id)
    @workout = ::PersonalWorkout.find(workout_id)
    mail(to: @user.email, subject: 'GymCloud')
  end

  def event_scheduled(user_id, creator_id, event_id)
    @user = ::User.find(user_id)
    @event = ::WorkoutEvent.find(event_id)
    @creator_name = ::User.find(creator_id).user_profile.full_name
    mail(to: @user.email, subject: 'GymCloud')
  end

  def event_changed(user_id, event_id)
    @user = ::User.find(user_id)
    # NOTE: We cannot change event time for now
    @event = ::WorkoutEvent.find(event_id)
    mail(to: @user.email, subject: 'GymCloud')
  end

  def results_added(user_id, event_id)
    @user = ::User.find(user_id)
    @event = ::WorkoutEvent.find(event_id)
    mail(to: @user.email, subject: 'GymCloud')
  end

  def comment_added(user_id, comment_id)
    @user = ::User.find(user_id)
    @comment = ::Comment.find(comment_id)
    mail(to: @user.email, subject: 'GymCloud')
  end

  def trial_expiration(user_id)
    @user = ::User.find(user_id)
    @days_left = (@user.trial_expiration.to_date - Date.today).to_i
    mail(to: @user.email, subject: 'GymCloud')
  end

  def provide_pro(user_id)
    @user = ::User.find(user_id)
    mail(to: ENV['MAILER_EMAIL'], subject: 'GymCloud client need a Pro')
  end

end
