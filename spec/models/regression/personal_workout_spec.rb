require 'rails_helper'

RSpec.describe PersonalWorkout do

  # === Relations ===
  it { is_expected.to belong_to :workout_template}
	it { is_expected.to belong_to :person}
  it { is_expected.to have_one :author}
	it { is_expected.to have_one :user}
	it { is_expected.to have_one :program_workout}
  it { is_expected.to have_many :activities}
	it { is_expected.to have_many :workout_exercises}
	it { is_expected.to have_many :workout_events}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :name }
	it { is_expected.to have_db_column :description }
	it { is_expected.to have_db_column :note }
	it { is_expected.to have_db_column :workout_template_id }
	it { is_expected.to have_db_column :person_id }
	it { is_expected.to have_db_column :status }
	it { is_expected.to have_db_column :video_url }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }
	it { is_expected.to have_db_column :workout_template_version }
	it { is_expected.to have_db_column :is_program_part }
	it { is_expected.to have_db_column :is_default_for_group }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["person_id"]}
	it { is_expected.to have_db_index ["workout_template_id"]}

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :name }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :name }
	it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :video_url }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :video_url }

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :name }
	it { is_expected.to validate_presence_of :workout_template_id }
	it { is_expected.to validate_presence_of :person_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  it { is_expected.to define_enum_for(:status).with(["inactive", "active"])}
  
end