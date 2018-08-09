require 'rails_helper'

describe Admin::UserProfilesController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/user_profiles/batch_action').to({:controller=>"admin/user_profiles", :action=>"batch_action"}) } 
	it { should route(:get, '/admin/user_profiles').to({:controller=>"admin/user_profiles", :action=>"index"}) } 
	it { should route(:get, '/admin/user_profiles/new').to({:controller=>"admin/user_profiles", :action=>"new"}) } 
	it { should route(:patch, '/admin/user_profiles/1').to({:controller=>"admin/user_profiles", :action=>"update", :id=>1}) } 
	it { should route(:post, '/admin/user_profiles').to({:controller=>"admin/user_profiles", :action=>"create"}) } 
	it { should route(:get, '/admin/user_profiles/1/edit').to({:controller=>"admin/user_profiles", :action=>"edit", :id=>1}) } 
	it { should route(:get, '/admin/user_profiles/1').to({:controller=>"admin/user_profiles", :action=>"show", :id=>1}) } 
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