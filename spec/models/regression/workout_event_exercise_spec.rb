require 'rails_helper'

RSpec.describe WorkoutEventExercise do

  # === Relations ===
  it { is_expected.to belong_to :workout_event}
	it { is_expected.to belong_to :workout_exercise}
  
  it { is_expected.to have_many :exercise_results}
	it { is_expected.to have_many :exercise_properties}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :workout_event_id }
	it { is_expected.to have_db_column :workout_exercise_id }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["workout_event_id"]}
	it { is_expected.to have_db_index ["workout_exercise_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end