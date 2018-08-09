require 'rails_helper'

describe Admin::UserAccountTypesController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/user_account_types/batch_action').to({:controller=>"admin/user_account_types", :action=>"batch_action"}) } 
	it { should route(:get, '/admin/user_account_types').to({:controller=>"admin/user_account_types", :action=>"index"}) } 
	it { should route(:get, '/admin/user_account_types/new').to({:controller=>"admin/user_account_types", :action=>"new"}) } 
	it { should route(:patch, '/admin/user_account_types/1').to({:controller=>"admin/user_account_types", :action=>"update", :id=>1}) } 
	it { should route(:post, '/admin/user_account_types').to({:controller=>"admin/user_account_types", :action=>"create"}) } 
	it { should route(:delete, '/admin/user_account_types/1').to({:controller=>"admin/user_account_types", :action=>"destroy", :id=>1}) } 
	it { should route(:get, '/admin/user_account_types/1/edit').to({:controller=>"admin/user_account_types", :action=>"edit", :id=>1}) } 
	it { should route(:get, '/admin/user_account_types/1').to({:controller=>"admin/user_account_types", :action=>"show", :id=>1}) } 
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