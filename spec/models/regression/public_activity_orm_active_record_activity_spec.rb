require 'rails_helper'

RSpec.describe PublicActivity::ORM::ActiveRecord::Activity do

  # === Relations ===
  it { is_expected.to belong_to :trackable}
	it { is_expected.to belong_to :owner}
	it { is_expected.to belong_to :recipient}
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :trackable_id }
	it { is_expected.to have_db_column :trackable_type }
	it { is_expected.to have_db_column :owner_id }
	it { is_expected.to have_db_column :owner_type }
	it { is_expected.to have_db_column :key }
	it { is_expected.to have_db_column :parameters }
	it { is_expected.to have_db_column :recipient_id }
	it { is_expected.to have_db_column :recipient_type }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end