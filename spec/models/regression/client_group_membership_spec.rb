require 'rails_helper'

RSpec.describe ClientGroupMembership do

  # === Relations ===
  it { is_expected.to belong_to :client_group}
	it { is_expected.to belong_to :client}
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :client_group_id }
	it { is_expected.to have_db_column :client_id }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["client_id", "client_group_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :client_group_id }
	it { is_expected.to validate_presence_of :client_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end