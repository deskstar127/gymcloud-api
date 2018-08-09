require 'rails_helper'

describe PasswordsController do
  # === Routes (REST) ===
  it { should route(:patch, '/users/password').to({:controller=>"passwords", :action=>"update"}) } 
	it { should route(:post, '/users/password').to({:controller=>"passwords", :action=>"create"}) } 
	it { should route(:get, '/users/password/new').to({:controller=>"passwords", :action=>"new"}) } 
	it { should route(:get, '/users/password/edit').to({:controller=>"passwords", :action=>"edit"}) } 
  # === Callbacks (Before) ===
  it { should use_before_filter(:require_no_authentication) }
	it { should use_before_filter(:assert_is_devise_resource!) }
	it { should use_before_filter(:verify_authenticity_token) }
	it { should use_before_filter(:set_paper_trail_enabled_for_controller) }
	it { should use_before_filter(:set_paper_trail_whodunnit) }
	it { should use_before_filter(:set_paper_trail_controller_info) }
	it { should use_before_filter(:assert_reset_token_passed) }
  # === Callbacks (After) ===
  it { should use_after_filter(:verify_same_origin_request) }
  # === Callbacks (Around) ===
  
end