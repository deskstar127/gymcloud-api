namespace :mailer_test do

  list = %i(
    welcome_new_user
    program_assigned
    workout_assigned
    event_scheduled
    event_changed
    results_added
    trial_expiration
    invitation_instructions
  )

  desc 'Print email list'
  task list: :environment do
    puts "\e[32m Availible tasks: \e[0m"
    list.unshift(:all)
    list.each { |item| puts "\e[33m rake mailer_test:#{item} \e[0m" }
  end

  desc 'Send all test emails'
  task all: list

  desc 'Send welcome_new_user'
  task welcome_new_user: :environment do
    ActiveRecord::Base.transaction do
      deliver_email HtmlMailer.welcome_new_user(user.id)
      puts "\e[32m welcome_new_user sent \e[0m"
      raise ActiveRecord::Rollback
    end
  end

  desc 'Send program_assigned'
  task program_assigned: :environment do
    ActiveRecord::Base.transaction do
      deliver_email HtmlMailer.program_assigned(user.id, personal_program.id)
      puts "\e[32m program_assigned sent \e[0m"
      raise ActiveRecord::Rollback
    end
  end

  desc 'Send workout_assigned'
  task workout_assigned: :environment do
    ActiveRecord::Base.transaction do
      deliver_email HtmlMailer.workout_assigned(user.id, personal_workout.id)
      puts "\e[32m workout_assigned sent \e[0m"
      raise ActiveRecord::Rollback
    end
  end

  desc 'Send event_scheduled'
  task event_scheduled: :environment do
    ActiveRecord::Base.transaction do
      deliver_email HtmlMailer.event_scheduled(user.id, event.id)
      puts "\e[32m event_scheduled sent \e[0m"
      raise ActiveRecord::Rollback
    end
  end

  desc 'Send event_changed'
  task event_changed: :environment do
    ActiveRecord::Base.transaction do
      deliver_email HtmlMailer.event_changed(user.id, event.id)
      puts "\e[32m event_changed sent \e[0m"
      raise ActiveRecord::Rollback
    end
  end

  desc 'Send results_added'
  task results_added: :environment do
    ActiveRecord::Base.transaction do
      deliver_email HtmlMailer.results_added(user.id, result.id)
      puts "\e[32m results_added sent \e[0m"
      raise ActiveRecord::Rollback
    end
  end

  desc 'Send trial_expiration'
  task trial_expiration: :environment do
    ActiveRecord::Base.transaction do
      deliver_email HtmlMailer.trial_expiration(user.id)
      puts "\e[32m trial_expiration sent \e[0m"
      raise ActiveRecord::Rollback
    end
  end

  desc 'Send invitation_instructions'
  task invitation_instructions: :environment do
    ActiveRecord::Base.transaction do
      deliver_email DeviseHtmlMailer.invitation_instructions(user, 'token')
      puts "\e[32m invitation_instructions sent \e[0m"
      raise ActiveRecord::Rollback
    end
  end

  def user
    profile = UserProfile.create!(
      first_name: 'FirstName',
      last_name: 'LastName'
    )
    User.create!(
      email: send_email_to,
      password: 'password',
      user_profile: profile
    )
  end

  def program_template
    author = user
    ProgramTemplate.create!(
      name: 'Program Template Name',
      author_id: author.id,
      user_id: author.id,
      is_public: false
    )
  end

  def personal_program
    PersonalProgram.create!(
      name: 'Personal Program Name',
      program_template_id: program_template.id,
      person_id: user.id
    )
  end

  def workout_template
    author = user
    WorkoutTemplate.create!(
      name: 'Workout Template Name',
      author_id: author.id,
      user_id: author.id,
      is_public: false
    )
  end

  def personal_workout
    PersonalWorkout.create!(
      name: 'Personal Workout Name',
      workout_template_id: workout_template.id,
      person_id: user.id
    )
  end

  def event
    WorkoutEvent.create!(
      personal_workout_id: personal_workout.id,
      begins_at: 12.hours.ago
    )
  end

  def result
    workout_event = event
    personal_workout = workout_event.personal_workout
    ExerciseResult.create!(
      workout_exercise_id: workout_exercise(personal_workout).id,
      workout_event_id: workout_event.id
    )
  end

  def workout_exercise(personal_workout)
    WorkoutExercise.create!(
      exercise_id: exercise.id,
      workout: personal_workout
    )
  end

  def exercise
    author = user
    Exercise.create!(
      name: 'Exercise name',
      author_id: author.id,
      user_id: author.id,
      is_public: false
    )
  end

  def send_email_to
    "YOUR_GMAIL+#{rand(0..300)}@gmail.com"
  end

  def mail_settings
    {
      address: 'smtp.gmail.com',
      port: 587,
      domain: 'gmail.com',
      user_name: 'YOUR_GMAIL@gmail.com',
      password: 'YOUR_PASSWORD',
      authentication: :plain,
      enable_starttls_auto: true
    }
  end

  def deliver_email(message)
    message.delivery_method(:smtp, mail_settings)
    message.deliver_now!
  end

end
