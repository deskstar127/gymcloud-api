require 'rails_helper'

RSpec.describe UserAccountType do

  # === Relations ===
  
  
  it { is_expected.to have_many :user_settings}
	it { is_expected.to have_many :users}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :name }
	it { is_expected.to have_db_column :icon }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :name }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :name }
	it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :icon }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :icon }

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :name }
	it { is_expected.to validate_presence_of :icon }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end