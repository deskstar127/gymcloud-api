require 'rails_helper'

RSpec.describe ProgramWeek do

  # === Relations ===
  it { is_expected.to belong_to :source}
	it { is_expected.to belong_to :program}
  
  it { is_expected.to have_many :clones}
	it { is_expected.to have_many :program_workouts}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :name }
	it { is_expected.to have_db_column :position }
	it { is_expected.to have_db_column :program_id }
	it { is_expected.to have_db_column :program_type }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }
	it { is_expected.to have_db_column :source_id }
	it { is_expected.to have_db_column :source_type }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["program_type", "program_id"]}

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :name }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :name }

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :name }
	it { is_expected.to validate_presence_of :position }
	it { is_expected.to validate_presence_of :program_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end