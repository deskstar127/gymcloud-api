require 'rails_helper'

describe Admin::CommentsController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/comments/batch_action').to({:controller=>"admin/comments", :action=>"batch_action"}) } 
	it { should route(:get, '/admin/comments').to({:controller=>"admin/comments", :action=>"index"}) } 
	it { should route(:get, '/admin/comments/new').to({:controller=>"admin/comments", :action=>"new"}) } 
	it { should route(:patch, '/admin/comments/1').to({:controller=>"admin/comments", :action=>"update", :id=>1}) } 
	it { should route(:post, '/admin/comments').to({:controller=>"admin/comments", :action=>"create"}) } 
	it { should route(:delete, '/admin/comments/1').to({:controller=>"admin/comments", :action=>"destroy", :id=>1}) } 
	it { should route(:get, '/admin/comments/1/edit').to({:controller=>"admin/comments", :action=>"edit", :id=>1}) } 
	it { should route(:get, '/admin/comments/1').to({:controller=>"admin/comments", :action=>"show", :id=>1}) } 
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