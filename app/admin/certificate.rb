ActiveAdmin.register Certificate do

  menu parent: 'Pro'

  permit_params :user_id, :status, :file

  actions :all, except: [:new, :edit]

  index do
    id_column
    column :status
    column :file do |model|
      link_to('link', model.file.url) unless model.file.blank?
    end
    column :user do |model|
      model.user.user_profile.full_name
    end
    column :created_at

    actions defaults: true do |model|
      options = {class: 'member_link'}
      [
        link_to('Verify', verify_admin_certificate_path(model), options),
        link_to('Decline', decline_admin_certificate_path(model), options)
      ].join.html_safe
    end
  end

  member_action :verify, method: :get do
    resource.status = :verified
    flash[:alert] = resource.errors.messages unless resource.save
    redirect_to :back
  end

  member_action :decline, method: :get do
    resource.status = :declined
    flash[:alert] = resource.errors.messages unless resource.save
    redirect_to :back
  end

  controller do

    def destroy
      return redirect_to :back unless resource.status == 'declined'
      super
    end

  end

end
