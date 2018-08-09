require 'rails_helper'

RSpec.describe GlobalProperty do

  # === Relations ===
  it { is_expected.to belong_to :default_unit}
	it { is_expected.to belong_to :save_unit}
  
  it { is_expected.to have_many :personal_properties}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :symbol }
	it { is_expected.to have_db_column :name }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }
	it { is_expected.to have_db_column :position }
	it { is_expected.to have_db_column :property_unit_id }
	it { is_expected.to have_db_column :save_property_unit_id }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["position"]}
	it { is_expected.to have_db_index ["symbol"]}

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :symbol }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :symbol }
	it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :name }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :name }

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :name }
	it { is_expected.to validate_presence_of :symbol }
	it { is_expected.to validate_presence_of :position }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end