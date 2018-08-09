ActiveAdmin.register ExerciseResult do

  menu parent: 'Trainings'

  permit_params :workout_event_id, :workout_exercise_id, :is_personal_best

end
