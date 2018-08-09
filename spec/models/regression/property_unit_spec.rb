require 'rails_helper'

RSpec.describe PropertyUnit do

  # === Relations ===
  
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :short_name }
	it { is_expected.to have_db_column :name }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["short_name"]}

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :name }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :name }
	it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :short_name }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :short_name }

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :name }
	it { is_expected.to validate_presence_of :short_name }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end