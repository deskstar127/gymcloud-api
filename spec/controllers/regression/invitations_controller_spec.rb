require 'rails_helper'

describe InvitationsController do
  # === Routes (REST) ===
  it { should route(:patch, '/users/invitation').to({:controller=>"invitations", :action=>"update"}) } 
	it { should route(:get, '/users/invitation/new').to({:controller=>"invitations", :action=>"new"}) } 
	it { should route(:post, '/users/invitation').to({:controller=>"invitations", :action=>"create"}) } 
	it { should route(:get, '/users/invitation/remove').to({:controller=>"invitations", :action=>"destroy"}) } 
	it { should route(:get, '/users/invitation/accept').to({:controller=>"invitations", :action=>"edit"}) } 
  # === Callbacks (Before) ===
  it { should use_before_filter(:verify_authenticity_token) }
	it { should use_before_filter(:resource_from_invitation_token) }
	it { should use_before_filter(:require_no_authentication) }
	it { should use_before_filter(:has_invitations_left?) }
	it { should use_before_filter(:authenticate_inviter!) }
	it { should use_before_filter(:assert_is_devise_resource!) }
	it { should use_before_filter(:set_paper_trail_enabled_for_controller) }
	it { should use_before_filter(:set_paper_trail_whodunnit) }
	it { should use_before_filter(:set_paper_trail_controller_info) }
  # === Callbacks (After) ===
  it { should use_after_filter(:verify_same_origin_request) }
  # === Callbacks (Around) ===
  
end