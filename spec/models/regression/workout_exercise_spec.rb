require 'rails_helper'

RSpec.describe WorkoutExercise do

  # === Relations ===
  it { is_expected.to belong_to :source}
	it { is_expected.to belong_to :exercise}
	it { is_expected.to belong_to :workout}
	it { is_expected.to belong_to :personal_workout}
  
  it { is_expected.to have_many :clones}
	it { is_expected.to have_many :exercise_properties}
	it { is_expected.to have_many :exercise_results}
	it { is_expected.to have_many :workout_event_exercises}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :exercise_id }
	it { is_expected.to have_db_column :workout_id }
	it { is_expected.to have_db_column :note }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }
	it { is_expected.to have_db_column :exercise_version }
	it { is_expected.to have_db_column :workout_type }
	it { is_expected.to have_db_column :order_name }
	it { is_expected.to have_db_column :position }
	it { is_expected.to have_db_column :source_id }
	it { is_expected.to have_db_column :source_type }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["exercise_id"]}
	it { is_expected.to have_db_index ["workout_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :exercise_id }
	it { is_expected.to validate_presence_of :workout_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end