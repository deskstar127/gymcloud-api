require 'rails_helper'

RSpec.describe RequestPro do

  # === Relations ===
  it { is_expected.to belong_to :client}
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :client_id }
	it { is_expected.to have_db_column :pro_provided }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :client_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end