require 'rails_helper'

RSpec.describe UserSettings do

  # === Relations ===
  it { is_expected.to belong_to :user}
	it { is_expected.to belong_to :user_account_type}



  # === Nested Attributes ===


  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :user_id }
	it { is_expected.to have_db_column :user_account_type_id }
	it { is_expected.to have_db_column :units_system }
	it { is_expected.to have_db_column :is_tutorial_finished }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["user_account_type_id"]}
	it { is_expected.to have_db_index ["user_id"]}

  # === Validations (Length) ===


  # === Validations (Presence) ===


  # === Validations (Numericality) ===



  # === Enums ===
  it { is_expected.to define_enum_for(:units_system).with(["imperial", "metric"])}

end