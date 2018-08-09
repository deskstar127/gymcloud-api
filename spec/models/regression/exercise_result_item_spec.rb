require 'rails_helper'

RSpec.describe ExerciseResultItem do

  # === Relations ===
  it { is_expected.to belong_to :exercise_result}
	it { is_expected.to belong_to :exercise_property}
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :exercise_result_id }
	it { is_expected.to have_db_column :exercise_property_id }
	it { is_expected.to have_db_column :value }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["exercise_property_id"]}
	it { is_expected.to have_db_index ["exercise_result_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :exercise_result_id }
	it { is_expected.to validate_presence_of :exercise_property_id }
	it { is_expected.to validate_presence_of :value }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end