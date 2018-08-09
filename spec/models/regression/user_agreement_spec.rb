require 'rails_helper'

RSpec.describe UserAgreement do

  # === Relations ===
  it { is_expected.to belong_to :pro}
	it { is_expected.to belong_to :client}
	it { is_expected.to belong_to :category}
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :pro_id }
	it { is_expected.to have_db_column :client_id }
	it { is_expected.to have_db_column :category_id }
	it { is_expected.to have_db_column :status }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :pro_id }
	it { is_expected.to validate_presence_of :client_id }
	it { is_expected.to validate_presence_of :category_id }
	it { is_expected.to validate_presence_of :status }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  it { is_expected.to define_enum_for(:status).with(["active", "paused", "finished"])}
  
end