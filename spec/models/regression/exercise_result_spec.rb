require 'rails_helper'

RSpec.describe ExerciseResult do

  # === Relations ===
  it { is_expected.to belong_to :workout_event}
	it { is_expected.to belong_to :workout_exercise}
  it { is_expected.to have_one :person}
  it { is_expected.to have_many :activities}
	it { is_expected.to have_many :exercise_result_items}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :workout_event_id }
	it { is_expected.to have_db_column :workout_exercise_id }
	it { is_expected.to have_db_column :is_personal_best }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["workout_event_id"]}
	it { is_expected.to have_db_index ["workout_exercise_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :workout_exercise_id }
	it { is_expected.to validate_presence_of :workout_event_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end