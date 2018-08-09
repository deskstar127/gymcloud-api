ActiveAdmin.register PersonalWorkout do

  menu parent: 'Personal'

  permit_params :name, :description, :note,
    :workout_template_id, :person_id,
    :status, :video_url

  controller do

    def create
      attributes = params[:personal_workout]
      template = ::WorkoutTemplate.find(attributes[:workout_template_id])
      user = ::User.find(attributes[:person_id])
      service = Services::PersonalAssignment::Workout.new(
        template: template,
        user: user
      )
      @personal_workout = service.process.result
      super
    end

  end

end
