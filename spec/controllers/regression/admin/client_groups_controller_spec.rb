require 'rails_helper'

describe Admin::ClientGroupsController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/client_groups/batch_action').to({:controller=>"admin/client_groups", :action=>"batch_action"}) } 
	it { should route(:get, '/admin/client_groups').to({:controller=>"admin/client_groups", :action=>"index"}) } 
	it { should route(:get, '/admin/client_groups/new').to({:controller=>"admin/client_groups", :action=>"new"}) } 
	it { should route(:patch, '/admin/client_groups/1').to({:controller=>"admin/client_groups", :action=>"update", :id=>1}) } 
	it { should route(:post, '/admin/client_groups').to({:controller=>"admin/client_groups", :action=>"create"}) } 
	it { should route(:delete, '/admin/client_groups/1').to({:controller=>"admin/client_groups", :action=>"destroy", :id=>1}) } 
	it { should route(:get, '/admin/client_groups/1/edit').to({:controller=>"admin/client_groups", :action=>"edit", :id=>1}) } 
	it { should route(:get, '/admin/client_groups/1').to({:controller=>"admin/client_groups", :action=>"show", :id=>1}) } 
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