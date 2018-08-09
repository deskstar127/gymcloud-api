require 'rails_helper'

RSpec.describe ClientGroup do

  # === Relations ===
  it { is_expected.to belong_to :pro}
  
  it { is_expected.to have_many :client_group_memberships}
	it { is_expected.to have_many :clients}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :name }
	it { is_expected.to have_db_column :pro_id }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :name }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :name }

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :name }
	it { is_expected.to validate_presence_of :pro_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end