require 'rails_helper'

describe Admin::ExercisesController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/exercises/batch_action').to({:controller=>"admin/exercises", :action=>"batch_action"}) } 
	it { should route(:get, '/admin/exercises').to({:controller=>"admin/exercises", :action=>"index"}) } 
	it { should route(:get, '/admin/exercises/new').to({:controller=>"admin/exercises", :action=>"new"}) } 
	it { should route(:patch, '/admin/exercises/1').to({:controller=>"admin/exercises", :action=>"update", :id=>1}) } 
	it { should route(:post, '/admin/exercises').to({:controller=>"admin/exercises", :action=>"create"}) } 
	it { should route(:delete, '/admin/exercises/1').to({:controller=>"admin/exercises", :action=>"destroy", :id=>1}) } 
	it { should route(:get, '/admin/exercises/1/edit').to({:controller=>"admin/exercises", :action=>"edit", :id=>1}) } 
	it { should route(:get, '/admin/exercises/1').to({:controller=>"admin/exercises", :action=>"show", :id=>1}) } 
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