ActiveAdmin.register ProgramPreset do

  menu parent: 'Presets'

  permit_params :name, :user_id, program_template_ids: []

  index do
    selectable_column
    id_column
    column :name
    column :user
    actions
  end

  filter :name
  filter :created_at
  filter :updated_at

  form do |f|
    f.inputs "#{f.object.class.name.titleize} Details" do
      f.input :name
      f.input :user_id,
        as: :select,
        collection: ::User.gymcloud_pros
      f.input :program_templates,
        as: :select,
        collection: [],
        multiple: true
    end
    f.actions
  end

  controller do

    before_filter :check_user, only: :new

    def check_user
      last = ::ProgramPreset.last
      @program_preset = ::ProgramPreset.new(user: last.user) unless last.nil?
    end

  end

  collection_action :user_program_templates, method: :get do
    user = ::User.find(params[:user_id])
    programs = user.program_templates.order(folder_id: :asc)
    render json: programs.as_json(include: :folder)
  end

end
