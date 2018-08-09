require 'rails_helper'

RSpec.describe ProgramTemplate do

  # === Relations ===
  it { is_expected.to belong_to :author}
	it { is_expected.to belong_to :user}
	it { is_expected.to belong_to :original}
	it { is_expected.to belong_to :folder}
  
  it { is_expected.to have_many :personal_programs}
	it { is_expected.to have_many :program_workouts}
	it { is_expected.to have_many :program_weeks}
	it { is_expected.to have_many :duplicates}
	it { is_expected.to have_many :versions}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :name }
	it { is_expected.to have_db_column :description }
	it { is_expected.to have_db_column :note }
	it { is_expected.to have_db_column :is_public }
	it { is_expected.to have_db_column :author_id }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }
	it { is_expected.to have_db_column :folder_id }
	it { is_expected.to have_db_column :deleted_at }
	it { is_expected.to have_db_column :user_id }
	it { is_expected.to have_db_column :original_id }
	it { is_expected.to have_db_column :weeks_count }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["author_id"]}
	it { is_expected.to have_db_index ["deleted_at"]}
	it { is_expected.to have_db_index ["folder_id"]}
	it { is_expected.to have_db_index ["original_id"]}
	it { is_expected.to have_db_index ["user_id"]}

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :name }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :name }

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :name }
	it { is_expected.to validate_presence_of :author_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end