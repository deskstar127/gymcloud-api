require 'rails_helper'

RSpec.describe PersonalProperty do

  # === Relations ===
  it { is_expected.to belong_to :global_property}
	it { is_expected.to belong_to :person}
  it { is_expected.to have_one :default_unit}
	it { is_expected.to have_one :save_unit}
  it { is_expected.to have_many :exercise_properties}
	it { is_expected.to have_many :property_units}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :global_property_id }
	it { is_expected.to have_db_column :position }
	it { is_expected.to have_db_column :is_visible }
	it { is_expected.to have_db_column :person_id }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["global_property_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :global_property_id }
	it { is_expected.to validate_presence_of :person_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end