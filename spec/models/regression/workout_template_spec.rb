require 'rails_helper'

RSpec.describe WorkoutTemplate do

  # === Relations ===
  it { is_expected.to belong_to :author}
	it { is_expected.to belong_to :user}
	it { is_expected.to belong_to :original}
	it { is_expected.to belong_to :folder}
	it { is_expected.to belong_to :video}
	it { is_expected.to belong_to :client_group}
  it { is_expected.to have_one :program_workout}
  it { is_expected.to have_many :personal_workouts}
	it { is_expected.to have_many :workout_exercises}
	it { is_expected.to have_many :duplicates}
	it { is_expected.to have_many :versions}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :name }
	it { is_expected.to have_db_column :description }
	it { is_expected.to have_db_column :note }
	it { is_expected.to have_db_column :video_url }
	it { is_expected.to have_db_column :is_public }
	it { is_expected.to have_db_column :author_id }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }
	it { is_expected.to have_db_column :folder_id }
	it { is_expected.to have_db_column :is_visible }
	it { is_expected.to have_db_column :deleted_at }
	it { is_expected.to have_db_column :video_id }
	it { is_expected.to have_db_column :user_id }
	it { is_expected.to have_db_column :original_id }
	it { is_expected.to have_db_column :client_group_id }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["author_id"]}
	it { is_expected.to have_db_index ["client_group_id"]}
	it { is_expected.to have_db_index ["deleted_at"]}
	it { is_expected.to have_db_index ["folder_id"]}
	it { is_expected.to have_db_index ["original_id"]}
	it { is_expected.to have_db_index ["user_id"]}

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :name }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :name }
	it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :video_url }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :video_url }

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :name }
	it { is_expected.to validate_presence_of :author_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end