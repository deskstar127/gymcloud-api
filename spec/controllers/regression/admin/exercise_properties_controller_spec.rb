require 'rails_helper'

describe Admin::ExercisePropertiesController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/exercise_properties/batch_action').to({:controller=>"admin/exercise_properties", :action=>"batch_action"}) } 
	it { should route(:get, '/admin/exercise_properties').to({:controller=>"admin/exercise_properties", :action=>"index"}) } 
	it { should route(:get, '/admin/exercise_properties/new').to({:controller=>"admin/exercise_properties", :action=>"new"}) } 
	it { should route(:patch, '/admin/exercise_properties/1').to({:controller=>"admin/exercise_properties", :action=>"update", :id=>1}) } 
	it { should route(:post, '/admin/exercise_properties').to({:controller=>"admin/exercise_properties", :action=>"create"}) } 
	it { should route(:delete, '/admin/exercise_properties/1').to({:controller=>"admin/exercise_properties", :action=>"destroy", :id=>1}) } 
	it { should route(:get, '/admin/exercise_properties/1/edit').to({:controller=>"admin/exercise_properties", :action=>"edit", :id=>1}) } 
	it { should route(:get, '/admin/exercise_properties/1').to({:controller=>"admin/exercise_properties", :action=>"show", :id=>1}) } 
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