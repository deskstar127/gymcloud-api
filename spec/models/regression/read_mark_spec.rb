require 'rails_helper'

RSpec.describe ReadMark do

  # === Relations ===
  it { is_expected.to belong_to :readable}
	it { is_expected.to belong_to :user}
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :readable_id }
	it { is_expected.to have_db_column :readable_type }
	it { is_expected.to have_db_column :user_id }
	it { is_expected.to have_db_column :timestamp }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["user_id", "readable_type", "readable_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :user_id }
	it { is_expected.to validate_presence_of :readable_type }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end