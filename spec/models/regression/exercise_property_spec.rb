require 'rails_helper'

RSpec.describe ExerciseProperty do

  # === Relations ===
  it { is_expected.to belong_to :source}
	it { is_expected.to belong_to :personal_property}
	it { is_expected.to belong_to :workout_exercise}
	it { is_expected.to belong_to :property_unit}
  
  it { is_expected.to have_many :clones}
	it { is_expected.to have_many :exercise_result_items}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :personal_property_id }
	it { is_expected.to have_db_column :workout_exercise_id }
	it { is_expected.to have_db_column :value }
	it { is_expected.to have_db_column :position }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }
	it { is_expected.to have_db_column :value2 }
	it { is_expected.to have_db_column :property_unit_id }
	it { is_expected.to have_db_column :source_id }
	it { is_expected.to have_db_column :source_type }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["personal_property_id"]}
	it { is_expected.to have_db_index ["workout_exercise_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :personal_property_id }
	it { is_expected.to validate_presence_of :workout_exercise_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end