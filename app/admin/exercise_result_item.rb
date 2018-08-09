ActiveAdmin.register ExerciseResultItem do

  menu parent: 'Trainings'

  permit_params :exercise_result_id, :exercise_property_id, :value

end
