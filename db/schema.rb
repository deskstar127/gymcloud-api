# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20161012132908) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.integer "author_id"
    t.string "author_type"
    t.text "body"
    t.datetime "created_at", precision: 6
    t.string "namespace"
    t.string "resource_id", null: false
    t.string "resource_type", null: false
    t.datetime "updated_at", precision: 6
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: :cascade do |t|
    t.datetime "created_at", precision: 6
    t.string "key"
    t.integer "owner_id"
    t.string "owner_type"
    t.text "parameters"
    t.integer "recipient_id"
    t.string "recipient_type"
    t.integer "trackable_id"
    t.string "trackable_type"
    t.datetime "updated_at", precision: 6
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

  create_table "admin_users", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "current_sign_in_at", precision: 6
    t.inet "current_sign_in_ip"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "last_sign_in_at", precision: 6
    t.inet "last_sign_in_ip"
    t.datetime "remember_created_at", precision: 6
    t.datetime "reset_password_sent_at", precision: 6
    t.string "reset_password_token"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true, using: :btree

  create_table "agreement_categories", force: :cascade do |t|
    t.string "client_title"
    t.datetime "created_at", precision: 6, null: false
    t.string "pro_title"
    t.string "symbol"
    t.string "title"
    t.datetime "updated_at", precision: 6, null: false
  end

  add_index "agreement_categories", ["symbol"], name: "index_agreement_categories_on_symbol", unique: true, using: :btree

  create_table "authentication_providers", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "name"
    t.datetime "updated_at", precision: 6, null: false
  end

  add_index "authentication_providers", ["name"], name: "index_authentication_providers_on_name", using: :btree

  create_table "certificates", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "file"
    t.integer "status", default: 0
    t.datetime "updated_at", null: false
    t.integer "user_id"
  end

  add_index "certificates", ["user_id"], name: "index_certificates_on_user_id", using: :btree

  create_table "client_group_memberships", force: :cascade do |t|
    t.integer "client_group_id"
    t.integer "client_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_index "client_group_memberships", ["client_id", "client_group_id"], name: "index_client_group_memberships_on_client_id_and_client_group_id", unique: true, using: :btree

  create_table "client_groups", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "name"
    t.integer "pro_id"
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "comment"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.datetime "created_at", precision: 6
    t.string "role", default: "comments"
    t.string "title", limit: 50, default: ""
    t.datetime "updated_at", precision: 6
    t.integer "user_id"
  end

  add_index "comments", ["commentable_id"], name: "index_comments_on_commentable_id", using: :btree
  add_index "comments", ["commentable_type"], name: "index_comments_on_commentable_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "exercise_properties", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.integer "personal_property_id"
    t.integer "position"
    t.integer "property_unit_id"
    t.integer "source_id"
    t.string "source_type"
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "value", precision: 14, scale: 5
    t.decimal "value2", precision: 14, scale: 5
    t.integer "workout_exercise_id"
  end

  add_index "exercise_properties", ["personal_property_id"], name: "index_exercise_properties_on_personal_property_id", using: :btree
  add_index "exercise_properties", ["workout_exercise_id"], name: "index_exercise_properties_on_workout_exercise_id", using: :btree

  create_table "exercise_result_items", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.integer "exercise_property_id"
    t.integer "exercise_result_id"
    t.datetime "updated_at", precision: 6, null: false
    t.decimal "value", precision: 14, scale: 5
  end

  add_index "exercise_result_items", ["exercise_property_id"], name: "index_exercise_result_items_on_exercise_property_id", using: :btree
  add_index "exercise_result_items", ["exercise_result_id"], name: "index_exercise_result_items_on_exercise_result_id", using: :btree

  create_table "exercise_results", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.boolean "is_personal_best"
    t.datetime "updated_at", precision: 6, null: false
    t.integer "workout_event_id"
    t.integer "workout_exercise_id"
  end

  add_index "exercise_results", ["workout_event_id"], name: "index_exercise_results_on_workout_event_id", using: :btree
  add_index "exercise_results", ["workout_exercise_id"], name: "index_exercise_results_on_workout_exercise_id", using: :btree

  create_table "exercises", force: :cascade do |t|
    t.integer "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "deleted_at", precision: 6
    t.text "description"
    t.integer "folder_id"
    t.boolean "is_public"
    t.string "name"
    t.integer "original_id"
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "video_id"
    t.string "video_url"
  end

  add_index "exercises", ["author_id"], name: "index_exercises_on_author_id", using: :btree
  add_index "exercises", ["deleted_at"], name: "index_exercises_on_deleted_at", using: :btree
  add_index "exercises", ["folder_id"], name: "index_exercises_on_folder_id", using: :btree
  add_index "exercises", ["original_id"], name: "index_exercises_on_original_id", using: :btree
  add_index "exercises", ["user_id"], name: "index_exercises_on_user_id", using: :btree

  create_table "folder_hierarchies", id: false, force: :cascade do |t|
    t.integer "ancestor_id", null: false
    t.integer "descendant_id", null: false
    t.integer "generations", null: false
  end

  add_index "folder_hierarchies", %w(ancestor_id descendant_id generations), name: "folder_anc_desc_idx", unique: true, using: :btree
  add_index "folder_hierarchies", ["descendant_id"], name: "folder_desc_idx", using: :btree

  create_table "folders", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "name"
    t.integer "parent_id"
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
  end

  add_index "folders", ["user_id"], name: "index_folders_on_user_id", using: :btree

  create_table "global_properties", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "name"
    t.integer "position"
    t.integer "property_unit_id"
    t.integer "save_property_unit_id"
    t.string "symbol"
    t.datetime "updated_at", precision: 6, null: false
  end

  add_index "global_properties", ["position"], name: "index_global_properties_on_position", unique: true, using: :btree
  add_index "global_properties", ["symbol"], name: "index_global_properties_on_symbol", unique: true, using: :btree

  create_table "global_properties_property_units", id: false, force: :cascade do |t|
    t.integer "global_property_id", null: false
    t.integer "property_unit_id", null: false
  end

  add_index "global_properties_property_units", ["global_property_id", "property_unit_id"], name: "global_property_unit_uniq_index", unique: true, using: :btree
  add_index "global_properties_property_units", ["property_unit_id", "global_property_id"], name: "global_property_unit_index", using: :btree

  create_table "logged_stripe_events", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.text "data"
    t.string "stripe_event_id"
    t.datetime "updated_at", precision: 6, null: false
  end

  add_index "logged_stripe_events", ["stripe_event_id"], name: "index_logged_stripe_events_on_stripe_event_id", using: :btree

  create_table "oauth_access_grants", force: :cascade do |t|
    t.integer "application_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.integer "expires_in", null: false
    t.text "redirect_uri", null: false
    t.integer "resource_owner_id", null: false
    t.datetime "revoked_at", precision: 6
    t.string "scopes"
    t.string "token", null: false
  end

  add_index "oauth_access_grants", ["token"], name: "index_oauth_access_grants_on_token", unique: true, using: :btree

  create_table "oauth_access_tokens", force: :cascade do |t|
    t.integer "application_id"
    t.datetime "created_at", precision: 6, null: false
    t.integer "expires_in"
    t.string "refresh_token"
    t.integer "resource_owner_id"
    t.datetime "revoked_at", precision: 6
    t.string "scopes"
    t.string "token", null: false
  end

  add_index "oauth_access_tokens", ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true, using: :btree
  add_index "oauth_access_tokens", ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id", using: :btree
  add_index "oauth_access_tokens", ["token"], name: "index_oauth_access_tokens_on_token", unique: true, using: :btree

  create_table "oauth_applications", force: :cascade do |t|
    t.datetime "created_at", precision: 6
    t.string "name", null: false
    t.text "redirect_uri", null: false
    t.string "scopes", default: "", null: false
    t.string "secret", null: false
    t.string "uid", null: false
    t.datetime "updated_at", precision: 6
  end

  add_index "oauth_applications", ["uid"], name: "index_oauth_applications_on_uid", unique: true, using: :btree

  create_table "personal_programs", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.text "description"
    t.string "name"
    t.text "note"
    t.integer "person_id"
    t.integer "program_template_id"
    t.integer "program_template_version"
    t.integer "status"
    t.datetime "updated_at", precision: 6, null: false
    t.integer "weeks_count"
  end

  add_index "personal_programs", ["person_id"], name: "index_personal_programs_on_person_id", using: :btree
  add_index "personal_programs", ["program_template_id"], name: "index_personal_programs_on_program_template_id", using: :btree

  create_table "personal_properties", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.integer "global_property_id"
    t.boolean "is_visible"
    t.integer "person_id"
    t.integer "position"
    t.datetime "updated_at", precision: 6, null: false
  end

  add_index "personal_properties", ["global_property_id"], name: "index_personal_properties_on_global_property_id", using: :btree

  create_table "personal_workouts", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.text "description"
    t.boolean "is_default_for_group"
    t.boolean "is_program_part", default: false
    t.string "name"
    t.text "note"
    t.integer "person_id"
    t.integer "status"
    t.datetime "updated_at", precision: 6, null: false
    t.string "video_url"
    t.integer "workout_template_id"
    t.integer "workout_template_version"
  end

  add_index "personal_workouts", ["person_id"], name: "index_personal_workouts_on_person_id", using: :btree
  add_index "personal_workouts", ["workout_template_id"], name: "index_personal_workouts_on_workout_template_id", using: :btree

  create_table "podcast_episodes", force: :cascade do |t|
    t.string "author"
    t.string "content_type"
    t.datetime "created_at", null: false
    t.string "description"
    t.string "duration"
    t.string "file"
    t.integer "file_size"
    t.datetime "published_at"
    t.string "title"
    t.datetime "updated_at", null: false
  end

  create_table "program_presets", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "name"
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
  end

  add_index "program_presets", ["user_id"], name: "index_program_presets_on_user_id", using: :btree

  create_table "program_presets_templates", id: false, force: :cascade do |t|
    t.integer "program_preset_id", null: false
    t.integer "program_template_id", null: false
  end

  create_table "program_templates", force: :cascade do |t|
    t.integer "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "deleted_at", precision: 6
    t.text "description"
    t.integer "folder_id"
    t.boolean "is_public"
    t.string "name"
    t.text "note"
    t.integer "original_id"
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "weeks_count"
  end

  add_index "program_templates", ["author_id"], name: "index_program_templates_on_author_id", using: :btree
  add_index "program_templates", ["deleted_at"], name: "index_program_templates_on_deleted_at", using: :btree
  add_index "program_templates", ["folder_id"], name: "index_program_templates_on_folder_id", using: :btree
  add_index "program_templates", ["original_id"], name: "index_program_templates_on_original_id", using: :btree
  add_index "program_templates", ["user_id"], name: "index_program_templates_on_user_id", using: :btree

  create_table "program_weeks", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "name"
    t.integer "position"
    t.integer "program_id"
    t.string "program_type"
    t.integer "source_id"
    t.string "source_type"
    t.datetime "updated_at", precision: 6, null: false
  end

  add_index "program_weeks", ["program_type", "program_id"], name: "index_program_weeks_on_program_type_and_program_id", using: :btree

  create_table "program_workouts", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.text "note"
    t.integer "position"
    t.integer "program_id"
    t.string "program_type"
    t.integer "source_id"
    t.string "source_type"
    t.datetime "updated_at", precision: 6, null: false
    t.integer "week_id"
    t.integer "workout_id"
    t.string "workout_type"
  end

  add_index "program_workouts", ["program_type", "program_id"], name: "index_program_workouts_on_program_type_and_program_id", using: :btree
  add_index "program_workouts", ["workout_type", "workout_id"], name: "index_program_workouts_on_workout_type_and_workout_id", using: :btree

  create_table "property_units", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "name"
    t.string "short_name"
    t.datetime "updated_at", precision: 6, null: false
  end

  add_index "property_units", ["short_name"], name: "index_property_units_on_short_name", unique: true, using: :btree

  create_table "read_marks", force: :cascade do |t|
    t.integer "readable_id"
    t.string "readable_type", limit: 255, null: false
    t.datetime "timestamp", precision: 6
    t.integer "user_id", null: false
  end

  add_index "read_marks", %w(user_id readable_type readable_id), name: "index_read_marks_on_user_id_and_readable_type_and_readable_id", using: :btree

  create_table "request_pros", force: :cascade do |t|
    t.integer "client_id"
    t.datetime "created_at", precision: 6, null: false
    t.boolean "pro_provided"
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "root_folder_categories", force: :cascade do |t|
    t.string "klass"
    t.string "name"
  end

  create_table "user_account_types", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.string "icon"
    t.string "name"
    t.datetime "updated_at", precision: 6, null: false
  end

  add_index "user_account_types", ["id"], name: "user_account_types_id_key", unique: true, using: :btree

  create_table "user_agreements", force: :cascade do |t|
    t.integer "category_id"
    t.integer "client_id"
    t.datetime "created_at", precision: 6, null: false
    t.integer "pro_id"
    t.integer "status"
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_authentications", force: :cascade do |t|
    t.integer "authentication_provider_id"
    t.datetime "created_at", precision: 6, null: false
    t.string "email"
    t.text "params"
    t.string "uid"
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
  end

  add_index "user_authentications", ["authentication_provider_id"], name: "index_user_authentications_on_authentication_provider_id", using: :btree
  add_index "user_authentications", ["user_id"], name: "index_user_authentications_on_user_id", using: :btree

  create_table "user_profiles", force: :cascade do |t|
    t.string "avatar"
    t.date "birthday"
    t.decimal "bodyfat"
    t.datetime "created_at", precision: 6, null: false
    t.string "employer"
    t.string "first_name"
    t.integer "gender"
    t.decimal "height"
    t.string "last_name"
    t.string "location"
    t.string "timezone"
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.decimal "weight"
    t.string "zip"
  end

  add_index "user_profiles", ["user_id"], name: "index_user_profiles_on_user_id", unique: true, using: :btree

  create_table "user_settings", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.boolean "is_mobile_tutorial_finished"
    t.boolean "is_presets_loaded"
    t.boolean "is_tutorial_finished"
    t.text "tutorial_steps", default: [], array: true
    t.integer "units_system"
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_account_type_id"
    t.integer "user_id"
  end

  add_index "user_settings", ["user_account_type_id"], name: "index_user_settings_on_user_account_type_id", using: :btree
  add_index "user_settings", ["user_id"], name: "index_user_settings_on_user_id", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.datetime "confirmation_sent_at", precision: 6
    t.string "confirmation_token"
    t.datetime "confirmed_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "current_sign_in_at", precision: 6
    t.inet "current_sign_in_ip"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: ""
    t.datetime "invitation_accepted_at", precision: 6
    t.datetime "invitation_created_at", precision: 6
    t.integer "invitation_limit"
    t.datetime "invitation_sent_at", precision: 6
    t.string "invitation_token"
    t.integer "invited_by_id"
    t.string "invited_by_type"
    t.boolean "is_active"
    t.boolean "is_trialing"
    t.datetime "last_sign_in_at", precision: 6
    t.inet "last_sign_in_ip"
    t.datetime "remember_created_at", precision: 6
    t.datetime "reset_password_sent_at", precision: 6
    t.string "reset_password_token"
    t.integer "sign_in_count", default: 0, null: false
    t.date "started_using_at"
    t.string "stripe_customer_id"
    t.datetime "subscription_end_at", precision: 6
    t.string "unconfirmed_email"
    t.datetime "updated_at", precision: 6, null: false
  end

  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["invitation_token"], name: "index_users_on_invitation_token", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.datetime "created_at", precision: 6
    t.string "event", null: false
    t.integer "item_id", null: false
    t.string "item_type", null: false
    t.text "object"
    t.string "whodunnit"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "videos", force: :cascade do |t|
    t.integer "author_id"
    t.datetime "created_at", precision: 6, null: false
    t.integer "duration"
    t.string "embed_url"
    t.string "name"
    t.string "preview_picture_url"
    t.integer "privacy", default: 1
    t.string "status"
    t.string "tmp_file"
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "uploaded_at", precision: 6
    t.integer "vimeo_id"
    t.string "vimeo_url"
  end

  add_index "videos", ["author_id"], name: "index_videos_on_author_id", using: :btree

  create_table "workout_event_exercises", force: :cascade do |t|
    t.datetime "created_at", precision: 6
    t.datetime "updated_at", precision: 6
    t.integer "workout_event_id"
    t.integer "workout_exercise_id"
  end

  add_index "workout_event_exercises", ["workout_event_id"], name: "index_workout_event_exercises_on_workout_event_id", using: :btree
  add_index "workout_event_exercises", ["workout_exercise_id"], name: "index_workout_event_exercises_on_workout_exercise_id", using: :btree

  create_table "workout_events", force: :cascade do |t|
    t.datetime "begins_at", precision: 6
    t.datetime "created_at", precision: 6, null: false
    t.datetime "ends_at", precision: 6
    t.boolean "is_completed"
    t.integer "personal_workout_id"
    t.datetime "updated_at", precision: 6, null: false
  end

  add_index "workout_events", ["personal_workout_id"], name: "index_workout_events_on_personal_workout_id", using: :btree

  create_table "workout_exercises", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.integer "exercise_id"
    t.integer "exercise_version"
    t.text "note"
    t.string "order_name"
    t.integer "position"
    t.integer "source_id"
    t.string "source_type"
    t.datetime "updated_at", precision: 6, null: false
    t.integer "workout_id"
    t.string "workout_type"
  end

  add_index "workout_exercises", ["exercise_id"], name: "index_workout_exercises_on_exercise_id", using: :btree
  add_index "workout_exercises", ["workout_id"], name: "index_workout_exercises_on_workout_id", using: :btree

  create_table "workout_templates", force: :cascade do |t|
    t.integer "author_id"
    t.integer "client_group_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "deleted_at", precision: 6
    t.text "description"
    t.integer "folder_id"
    t.boolean "is_public"
    t.boolean "is_visible", default: true
    t.string "name"
    t.text "note"
    t.integer "original_id"
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.integer "video_id"
    t.string "video_url"
  end

  add_index "workout_templates", ["author_id"], name: "index_workout_templates_on_author_id", using: :btree
  add_index "workout_templates", ["client_group_id"], name: "index_workout_templates_on_client_group_id", using: :btree
  add_index "workout_templates", ["deleted_at"], name: "index_workout_templates_on_deleted_at", using: :btree
  add_index "workout_templates", ["folder_id"], name: "index_workout_templates_on_folder_id", using: :btree
  add_index "workout_templates", ["original_id"], name: "index_workout_templates_on_original_id", using: :btree
  add_index "workout_templates", ["user_id"], name: "index_workout_templates_on_user_id", using: :btree

  add_foreign_key "certificates", "users"
  add_foreign_key "exercise_properties", "personal_properties"
  add_foreign_key "exercise_properties", "workout_exercises"
  add_foreign_key "exercise_result_items", "exercise_properties"
  add_foreign_key "exercise_result_items", "exercise_results"
  add_foreign_key "exercise_results", "workout_events"
  add_foreign_key "exercise_results", "workout_exercises"
  add_foreign_key "folders", "users"
  add_foreign_key "personal_programs", "program_templates"
  add_foreign_key "personal_properties", "global_properties"
  add_foreign_key "personal_workouts", "workout_templates"
  add_foreign_key "program_presets", "users"
  add_foreign_key "user_authentications", "authentication_providers"
  add_foreign_key "user_authentications", "users"
  add_foreign_key "user_settings", "user_account_types"
  add_foreign_key "workout_event_exercises", "workout_events"
  add_foreign_key "workout_event_exercises", "workout_exercises"
  add_foreign_key "workout_events", "personal_workouts"
  add_foreign_key "workout_exercises", "exercises"
  add_foreign_key "workout_templates", "client_groups"
end
