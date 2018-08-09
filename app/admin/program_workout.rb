ActiveAdmin.register ProgramWorkout do

  menu parent: 'Pro'

  permit_params :workout_id, :workout_type, :program_id, :program_type, :note

  form do |f|
    f.inputs "#{f.object.class.name.titleize} Details" do
      f.input :workout_id
      f.input :workout_type, collection: %w(WorkoutTemplate PersonalWorkout)
      f.input :program_id
      f.input :program_type, collection: %w(ProgramTemplate PersonalProgram)
      f.input :note
    end
    f.actions
  end

end
