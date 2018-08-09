require 'rails_helper'

RSpec.describe AgreementCategory do

  # === Relations ===
  
  
  it { is_expected.to have_many :user_agreements}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :title }
	it { is_expected.to have_db_column :pro_title }
	it { is_expected.to have_db_column :client_title }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }
	it { is_expected.to have_db_column :symbol }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["symbol"]}

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :title }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :title }
	it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :pro_title }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :pro_title }
	it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :symbol }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :symbol }

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :symbol }
	it { is_expected.to validate_presence_of :title }
	it { is_expected.to validate_presence_of :pro_title }
	it { is_expected.to validate_presence_of :client_title }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end