ActiveAdmin.register PublicActivity::Activity, as: 'Notification' do

  menu parent: 'Communication'

  actions :index

  index do
    id_column

    column :who, sortable: :owner_id do |model|
      owner = model.owner
      if owner
        link_to model.owner.email, admin_user_path(model.owner)
      else
        'Deleted user'
      end
    end

    column :action do |model|
      action = model.key.split('.').last
      css    = {
        create:           :green,
        update:           :orange,
        destroy:          :red
      }[action.to_sym] || :no

      span action.humanize, class: "status_tag #{css}"
    end

    column :what, sortable: :trackable_type do |model|
      tracked = model.trackable
      type    = model.trackable_type
      if tracked
        name = tracked.try(:name) || tracked.try(:display_name) || type
        url  = "admin_#{type.underscore}_path"
        link_to name, send(url, tracked)
      else
        "#{model.trackable_type} (Deleted now)"
      end
    end

    column 'When', :created_at
  end

  filter :owner, as: :select,
          collection: -> { User.all.map { |c| [c.email, c.id] } }
  filter :trackable_type
  filter :created_at

end
