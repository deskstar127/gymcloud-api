require 'rails_helper'

RSpec.describe Comment do

  # === Relations ===
  it { is_expected.to belong_to :user}
	it { is_expected.to belong_to :commentable}
  
  it { is_expected.to have_many :activities}
	it { is_expected.to have_many :read_marks}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :title }
	it { is_expected.to have_db_column :comment }
	it { is_expected.to have_db_column :commentable_id }
	it { is_expected.to have_db_column :commentable_type }
	it { is_expected.to have_db_column :user_id }
	it { is_expected.to have_db_column :role }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["commentable_id"]}
	it { is_expected.to have_db_index ["commentable_type"]}
	it { is_expected.to have_db_index ["user_id"]}

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :title }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :title }

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :comment }
	it { is_expected.to validate_presence_of :user_id }
	it { is_expected.to validate_presence_of :commentable_id }
	it { is_expected.to validate_presence_of :commentable_type }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end