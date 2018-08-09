ActiveAdmin.register ExerciseProperty do

  menu parent: 'Pro'

  permit_params :personal_property_id, :workout_exercise_id,
    :value, :value2, :position

end
