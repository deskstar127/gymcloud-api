class PreviewController < ApplicationController
  def invitation_instructions
    @resource = User.first
    render template: 'devise_html_mailer/invitation_instructions'
  end
end
