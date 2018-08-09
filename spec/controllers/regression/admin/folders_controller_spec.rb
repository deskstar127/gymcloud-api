require 'rails_helper'

describe Admin::FoldersController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/folders/batch_action').to({:controller=>"admin/folders", :action=>"batch_action"}) } 
	it { should route(:get, '/admin/folders').to({:controller=>"admin/folders", :action=>"index"}) } 
	it { should route(:get, '/admin/folders/new').to({:controller=>"admin/folders", :action=>"new"}) } 
	it { should route(:patch, '/admin/folders/1').to({:controller=>"admin/folders", :action=>"update", :id=>1}) } 
	it { should route(:post, '/admin/folders').to({:controller=>"admin/folders", :action=>"create"}) } 
	it { should route(:delete, '/admin/folders/1').to({:controller=>"admin/folders", :action=>"destroy", :id=>1}) } 
	it { should route(:get, '/admin/folders/1/edit').to({:controller=>"admin/folders", :action=>"edit", :id=>1}) } 
	it { should route(:get, '/admin/folders/1').to({:controller=>"admin/folders", :action=>"show", :id=>1}) } 
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