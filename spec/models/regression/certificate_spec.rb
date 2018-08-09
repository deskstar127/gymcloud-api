require 'rails_helper'

RSpec.describe Certificate do

  # === Relations ===
  it { is_expected.to belong_to :user}
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :user_id }
	it { is_expected.to have_db_column :status }
	it { is_expected.to have_db_column :file }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["user_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :status }
	it { is_expected.to validate_presence_of :file }
	it { is_expected.to validate_presence_of :user_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  it { is_expected.to define_enum_for(:status).with(["unverified", "verified", "declined"])}
  
end