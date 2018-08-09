require 'rails_helper'

describe Admin::UserAgreementsController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/user_agreements/batch_action').to({:controller=>"admin/user_agreements", :action=>"batch_action"}) } 
	it { should route(:get, '/admin/user_agreements').to({:controller=>"admin/user_agreements", :action=>"index"}) } 
	it { should route(:get, '/admin/user_agreements/new').to({:controller=>"admin/user_agreements", :action=>"new"}) } 
	it { should route(:patch, '/admin/user_agreements/1').to({:controller=>"admin/user_agreements", :action=>"update", :id=>1}) } 
	it { should route(:post, '/admin/user_agreements').to({:controller=>"admin/user_agreements", :action=>"create"}) } 
	it { should route(:delete, '/admin/user_agreements/1').to({:controller=>"admin/user_agreements", :action=>"destroy", :id=>1}) } 
	it { should route(:get, '/admin/user_agreements/1/edit').to({:controller=>"admin/user_agreements", :action=>"edit", :id=>1}) } 
	it { should route(:get, '/admin/user_agreements/1').to({:controller=>"admin/user_agreements", :action=>"show", :id=>1}) } 
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