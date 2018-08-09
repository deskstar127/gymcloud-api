require 'rails_helper'

RSpec.describe ActiveAdmin::Comment do

  # === Relations ===
  it { is_expected.to belong_to :resource}
	it { is_expected.to belong_to :author}
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :namespace }
	it { is_expected.to have_db_column :body }
	it { is_expected.to have_db_column :resource_id }
	it { is_expected.to have_db_column :resource_type }
	it { is_expected.to have_db_column :author_id }
	it { is_expected.to have_db_column :author_type }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["author_type", "author_id"]}
	it { is_expected.to have_db_index ["namespace"]}
	it { is_expected.to have_db_index ["resource_type", "resource_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :body }
	it { is_expected.to validate_presence_of :namespace }
	it { is_expected.to validate_presence_of :resource }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end