require 'rails_helper'

RSpec.describe WorkoutEvent do

  # === Relations ===
  it { is_expected.to belong_to :personal_workout}
  it { is_expected.to have_one :workout_template}
	it { is_expected.to have_one :person}
  it { is_expected.to have_many :activities}
	it { is_expected.to have_many :comments}
	it { is_expected.to have_many :exercise_results}
	it { is_expected.to have_many :workout_event_exercises}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :personal_workout_id }
	it { is_expected.to have_db_column :begins_at }
	it { is_expected.to have_db_column :ends_at }
	it { is_expected.to have_db_column :is_completed }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["personal_workout_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :personal_workout_id }
	it { is_expected.to validate_presence_of :begins_at }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end