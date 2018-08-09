require 'rails_helper'

RSpec.describe FolderHierarchy do

  # === Relations ===
  it { is_expected.to belong_to :ancestor}
	it { is_expected.to belong_to :descendant}
  
  

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :ancestor_id }
	it { is_expected.to have_db_column :descendant_id }
	it { is_expected.to have_db_column :generations }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["ancestor_id", "descendant_id", "generations"]}
	it { is_expected.to have_db_index ["descendant_id"]}

  # === Validations (Length) ===
  

  # === Validations (Presence) ===
  

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end