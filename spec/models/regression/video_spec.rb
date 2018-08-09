require 'rails_helper'

RSpec.describe Video do

  # === Relations ===
  it { is_expected.to belong_to :author}
  
  it { is_expected.to have_many :exercises}
	it { is_expected.to have_many :workout_templates}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :vimeo_id }
	it { is_expected.to have_db_column :tmp_file }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }
	it { is_expected.to have_db_column :privacy }
	it { is_expected.to have_db_column :name }
	it { is_expected.to have_db_column :duration }
	it { is_expected.to have_db_column :preview_picture_url }
	it { is_expected.to have_db_column :vimeo_url }
	it { is_expected.to have_db_column :status }
	it { is_expected.to have_db_column :embed_url }
	it { is_expected.to have_db_column :uploaded_at }
	it { is_expected.to have_db_column :author_id }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["author_id"]}

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(255)).for :name }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(256)).for :name }

  # === Validations (Presence) ===
  

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  it { is_expected.to define_enum_for(:privacy).with(["anybody", "nobody", "contacts", "password", "disable"])}
  
end