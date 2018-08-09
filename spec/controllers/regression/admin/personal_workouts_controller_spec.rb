require 'rails_helper'

describe Admin::PersonalWorkoutsController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/personal_workouts').to({:controller=>"admin/personal_workouts", :action=>"create"}) } 
	it { should route(:post, '/admin/personal_workouts/batch_action').to({:controller=>"admin/personal_workouts", :action=>"batch_action"}) } 
	it { should route(:get, '/admin/personal_workouts').to({:controller=>"admin/personal_workouts", :action=>"index"}) } 
	it { should route(:get, '/admin/personal_workouts/new').to({:controller=>"admin/personal_workouts", :action=>"new"}) } 
	it { should route(:patch, '/admin/personal_workouts/1').to({:controller=>"admin/personal_workouts", :action=>"update", :id=>1}) } 
	it { should route(:delete, '/admin/personal_workouts/1').to({:controller=>"admin/personal_workouts", :action=>"destroy", :id=>1}) } 
	it { should route(:get, '/admin/personal_workouts/1/edit').to({:controller=>"admin/personal_workouts", :action=>"edit", :id=>1}) } 
	it { should route(:get, '/admin/personal_workouts/1').to({:controller=>"admin/personal_workouts", :action=>"show", :id=>1}) } 
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