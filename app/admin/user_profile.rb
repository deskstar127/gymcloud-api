ActiveAdmin.register UserProfile do

  menu parent: 'Users'

  permit_params :user_id, :first_name, :last_name, :gender, :birthday,
    :height, :weight, :bodyfat, :location, :zip, :employer

  scope :all, default: true
  scope :pros
  scope :clients

  actions :all, except: [:destroy]

  index do
    selectable_column
    id_column
    column :avatar do |model|
      image_tag(model.avatar.url(:thumb), width: 20) unless model.avatar.blank?
    end
    column :first_name
    column :last_name
    column :email do |model|
      model.user.email
    end
    column :age do |model|
      (Date.today - model.birthday).to_i / 365 unless model.birthday.blank?
    end
    column :gender
    column :zip
    column :pro do |model|
      pro = model.user&.pros&.last&.user_profile
      link_to(pro.full_name, [:admin, pro]) if pro
    end

    actions
  end

  filter :first_name
  filter :last_name
  filter :user_email, as: :string
  filter :gender
  filter :height
  filter :weight
  filter :bodyfat
  filter :location
  filter :zip
  filter :employer
  filter :birthday
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "#{f.object.class.name.titleize} Details" do
      f.input :user
      f.input :gender, as: :select, collection: UserProfile.genders.keys
      f.input :height
      f.input :weight
      f.input :bodyfat
      f.input :first_name
      f.input :last_name
      f.input :location
      f.input :zip
      f.input :employer
      f.input :birthday, as: :datepicker
    end
    f.actions
  end

  controller do
    def scoped_collection
      super.distinct.joins { user }
    end
  end

end
