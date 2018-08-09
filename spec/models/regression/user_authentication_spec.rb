require 'rails_helper'

RSpec.describe UserAuthentication do

  # === Relations ===
  it { is_expected.to belong_to :user}
	it { is_expected.to belong_to :authentication_provider}
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :user_id }
	it { is_expected.to have_db_column :authentication_provider_id }
	it { is_expected.to have_db_column :uid }
	it { is_expected.to have_db_column :params }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }
	it { is_expected.to have_db_column :email }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["authentication_provider_id"]}
	it { is_expected.to have_db_index ["user_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end