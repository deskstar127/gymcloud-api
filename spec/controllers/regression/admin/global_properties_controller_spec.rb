require 'rails_helper'

describe Admin::GlobalPropertiesController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/global_properties').to({:controller=>"admin/global_properties", :action=>"create"}) } 
	it { should route(:post, '/admin/global_properties/batch_action').to({:controller=>"admin/global_properties", :action=>"batch_action"}) } 
	it { should route(:get, '/admin/global_properties').to({:controller=>"admin/global_properties", :action=>"index"}) } 
	it { should route(:get, '/admin/global_properties/new').to({:controller=>"admin/global_properties", :action=>"new"}) } 
	it { should route(:patch, '/admin/global_properties/1').to({:controller=>"admin/global_properties", :action=>"update", :id=>1}) } 
	it { should route(:delete, '/admin/global_properties/1').to({:controller=>"admin/global_properties", :action=>"destroy", :id=>1}) } 
	it { should route(:get, '/admin/global_properties/1/edit').to({:controller=>"admin/global_properties", :action=>"edit", :id=>1}) } 
	it { should route(:get, '/admin/global_properties/1').to({:controller=>"admin/global_properties", :action=>"show", :id=>1}) } 
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