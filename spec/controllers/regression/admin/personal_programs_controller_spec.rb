require 'rails_helper'

describe Admin::PersonalProgramsController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/personal_programs').to({:controller=>"admin/personal_programs", :action=>"create"}) } 
	it { should route(:post, '/admin/personal_programs/batch_action').to({:controller=>"admin/personal_programs", :action=>"batch_action"}) } 
	it { should route(:get, '/admin/personal_programs').to({:controller=>"admin/personal_programs", :action=>"index"}) } 
	it { should route(:get, '/admin/personal_programs/new').to({:controller=>"admin/personal_programs", :action=>"new"}) } 
	it { should route(:patch, '/admin/personal_programs/1').to({:controller=>"admin/personal_programs", :action=>"update", :id=>1}) } 
	it { should route(:delete, '/admin/personal_programs/1').to({:controller=>"admin/personal_programs", :action=>"destroy", :id=>1}) } 
	it { should route(:get, '/admin/personal_programs/1/edit').to({:controller=>"admin/personal_programs", :action=>"edit", :id=>1}) } 
	it { should route(:get, '/admin/personal_programs/1').to({:controller=>"admin/personal_programs", :action=>"show", :id=>1}) } 
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