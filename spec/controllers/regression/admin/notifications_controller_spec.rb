require 'rails_helper'

describe Admin::NotificationsController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/notifications/batch_action').to({:controller=>"admin/notifications", :action=>"batch_action"}) } 
	it { should route(:get, '/admin/notifications').to({:controller=>"admin/notifications", :action=>"index"}) } 
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