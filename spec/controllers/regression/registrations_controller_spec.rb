require 'rails_helper'

describe RegistrationsController do
  # === Routes (REST) ===
  it { should route(:post, '/users').to({:controller=>"registrations", :action=>"create"}) } 
	it { should route(:get, '/users/sign_up').to({:controller=>"registrations", :action=>"new"}) } 
	it { should route(:patch, '/users').to({:controller=>"registrations", :action=>"update"}) } 
	it { should route(:delete, '/users').to({:controller=>"registrations", :action=>"destroy"}) } 
	it { should route(:get, '/users/cancel').to({:controller=>"registrations", :action=>"cancel"}) } 
	it { should route(:get, '/users/edit').to({:controller=>"registrations", :action=>"edit"}) } 
  # === Callbacks (Before) ===
  it { should use_before_filter(:authenticate_scope!) }
	it { should use_before_filter(:require_no_authentication) }
	it { should use_before_filter(:assert_is_devise_resource!) }
	it { should use_before_filter(:verify_authenticity_token) }
	it { should use_before_filter(:set_paper_trail_enabled_for_controller) }
	it { should use_before_filter(:set_paper_trail_whodunnit) }
	it { should use_before_filter(:set_paper_trail_controller_info) }
  # === Callbacks (After) ===
  it { should use_after_filter(:verify_same_origin_request) }
  # === Callbacks (Around) ===
  
end