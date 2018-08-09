require 'rails_helper'

describe Admin::OldCommentsController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/old_comments').to({:controller=>"admin/old_comments", :action=>"create"}) } 
	it { should route(:get, '/admin/old_comments').to({:controller=>"admin/old_comments", :action=>"index"}) } 
	it { should route(:delete, '/admin/old_comments/1').to({:controller=>"admin/old_comments", :action=>"destroy", :id=>1}) } 
	it { should route(:get, '/admin/old_comments/1').to({:controller=>"admin/old_comments", :action=>"show", :id=>1}) } 
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