require 'rails_helper'

RSpec.describe User do

  # === Relations ===
  it { is_expected.to belong_to :invited_by}
  it { is_expected.to have_one :user_profile}
	it { is_expected.to have_one :user_settings}
  it { is_expected.to have_many :activities}
	it { is_expected.to have_many :certificates}
	it { is_expected.to have_many :authentications}
	it { is_expected.to have_many :agreements_as_pro}
	it { is_expected.to have_many :agreements_as_client}
	it { is_expected.to have_many :pros}
	it { is_expected.to have_many :clients}
	it { is_expected.to have_many :client_group_memberships}
	it { is_expected.to have_many :client_groups}
	it { is_expected.to have_many :client_groups_as_client}
	it { is_expected.to have_many :exercises}
	it { is_expected.to have_many :workout_templates}
	it { is_expected.to have_many :personal_workouts}
	it { is_expected.to have_many :program_templates}
	it { is_expected.to have_many :personal_programs}
	it { is_expected.to have_many :workout_events}
	it { is_expected.to have_many :personal_properties}
	it { is_expected.to have_many :exercise_results}
	it { is_expected.to have_many :folders}
	it { is_expected.to have_many :videos}
	it { is_expected.to have_many :exercises_as_author}
	it { is_expected.to have_many :program_templates_as_author}
	it { is_expected.to have_many :workout_templates_as_author}
	it { is_expected.to have_many :request_pros}
	it { is_expected.to have_many :read_marks}

  # === Nested Attributes ===
  

  # === Database (Columns) ===
  it { is_expected.to have_db_column :id }
	it { is_expected.to have_db_column :email }
	it { is_expected.to have_db_column :encrypted_password }
	it { is_expected.to have_db_column :reset_password_token }
	it { is_expected.to have_db_column :reset_password_sent_at }
	it { is_expected.to have_db_column :remember_created_at }
	it { is_expected.to have_db_column :sign_in_count }
	it { is_expected.to have_db_column :current_sign_in_at }
	it { is_expected.to have_db_column :last_sign_in_at }
	it { is_expected.to have_db_column :current_sign_in_ip }
	it { is_expected.to have_db_column :last_sign_in_ip }
	it { is_expected.to have_db_column :confirmation_token }
	it { is_expected.to have_db_column :confirmed_at }
	it { is_expected.to have_db_column :confirmation_sent_at }
	it { is_expected.to have_db_column :unconfirmed_email }
	it { is_expected.to have_db_column :created_at }
	it { is_expected.to have_db_column :updated_at }
	it { is_expected.to have_db_column :invitation_token }
	it { is_expected.to have_db_column :invitation_created_at }
	it { is_expected.to have_db_column :invitation_sent_at }
	it { is_expected.to have_db_column :invitation_accepted_at }
	it { is_expected.to have_db_column :invitation_limit }
	it { is_expected.to have_db_column :invited_by_id }
	it { is_expected.to have_db_column :invited_by_type }
	it { is_expected.to have_db_column :is_active }
	it { is_expected.to have_db_column :stripe_customer_id }
	it { is_expected.to have_db_column :is_trialing }
	it { is_expected.to have_db_column :subscription_end_at }
	it { is_expected.to have_db_column :started_using_at }

  # === Database (Indexes) ===
  it { is_expected.to have_db_index ["confirmation_token"]}
	it { is_expected.to have_db_index ["email"]}
	it { is_expected.to have_db_index ["invitation_token"]}
	it { is_expected.to have_db_index ["reset_password_token"]}

  # === Validations (Length) ===
  it { is_expected.to allow_value(Faker::Lorem.characters(6)).for :password }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(5)).for :password }
	it { is_expected.to allow_value(Faker::Lorem.characters(128)).for :password }
	it { is_expected.not_to allow_value(Faker::Lorem.characters(129)).for :password }

  # === Validations (Presence) ===
  it { is_expected.to validate_presence_of :email }
	it { is_expected.to validate_presence_of :password }

  # === Validations (Numericality) ===
  

  
  # === Enums ===
  
  
end