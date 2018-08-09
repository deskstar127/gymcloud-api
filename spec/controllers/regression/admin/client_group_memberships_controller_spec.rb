require 'rails_helper'

describe Admin::ClientGroupMembershipsController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/client_group_memberships/batch_action').to({:controller=>"admin/client_group_memberships", :action=>"batch_action"}) } 
	it { should route(:get, '/admin/client_group_memberships').to({:controller=>"admin/client_group_memberships", :action=>"index"}) } 
	it { should route(:get, '/admin/client_group_memberships/new').to({:controller=>"admin/client_group_memberships", :action=>"new"}) } 
	it { should route(:patch, '/admin/client_group_memberships/1').to({:controller=>"admin/client_group_memberships", :action=>"update", :id=>1}) } 
	it { should route(:post, '/admin/client_group_memberships').to({:controller=>"admin/client_group_memberships", :action=>"create"}) } 
	it { should route(:delete, '/admin/client_group_memberships/1').to({:controller=>"admin/client_group_memberships", :action=>"destroy", :id=>1}) } 
	it { should route(:get, '/admin/client_group_memberships/1/edit').to({:controller=>"admin/client_group_memberships", :action=>"edit", :id=>1}) } 
	it { should route(:get, '/admin/client_group_memberships/1').to({:controller=>"admin/client_group_memberships", :action=>"show", :id=>1}) } 
  # === Callbacks (Before) ===
  it { should use_before_filter(:verify_authenticity_token) }
	it { should use_before_filter(:set_paper_trail_enabled_for_controller) }
	it { should use_before_filter(:set_paper_trail_whodunnit) }
	it { should use_before_filter(:set_paper_trail_controller_info) }
	it { should use_before_filter(:only_render_implemented_actions) }
	it { should use_before_filter(:authenticate_active_admin_user) }
	it { should use_before_filter(:set_current_tab) }
  # === Callbacks (After) ===
  it { should use_after_filter(:verify_same_origin_request) }
  # === Callbacks (Around) ===
  
end