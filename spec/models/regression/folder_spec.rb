require 'rails_helper'

RSpec.describe Folder do

  # === Relations ===
  it { is_expected.to belong_to :parent}
	it { is_expected.to belong_to :user}
  
  it { is_expected.to have_many :children}
	it { is_expected.to have_many :ancestor_hierarchies}
	it { is_expected.to have_many :self_and_ancestors}
	it { is_expected.to have_many :descendant_hierarchies}
	it { is_expected.to have_many :self_and_descendants}
	it { is_expected.to have_many :exercises}
	it { is_expected.to have_many :workout_templates}
	it { is_expected.to have_many :program_templates}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :name }
	it { is_expected.to have_db_column :user_id }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }
	it { is_expected.to have_db_column :parent_id }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["user_id"]}

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :name }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :name }

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :name }
	it { is_expected.to validate_presence_of :user_id }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end