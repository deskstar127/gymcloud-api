require 'rails_helper'

RSpec.describe PersonalProgram do

  # === Relations ===
  it { is_expected.to belong_to :program_template}
	it { is_expected.to belong_to :person}
  it { is_expected.to have_one :author}
	it { is_expected.to have_one :user}
  it { is_expected.to have_many :activities}
	it { is_expected.to have_many :program_workouts}
	it { is_expected.to have_many :program_weeks}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :name }
	it { is_expected.to have_db_column :description }
	it { is_expected.to have_db_column :note }
	it { is_expected.to have_db_column :program_template_id }
	it { is_expected.to have_db_column :status }
	it { is_expected.to have_db_column :person_id }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }
	it { is_expected.to have_db_column :program_template_version }
	it { is_expected.to have_db_column :weeks_count }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["person_id"]}
	it { is_expected.to have_db_index ["program_template_id"]}

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :name }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :name }

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :name }
	it { is_expected.to validate_presence_of :program_template_id }
	it { is_expected.to validate_presence_of :person_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  it { is_expected.to define_enum_for(:status).with(["inactive", "active"])}
  
end