require 'rails_helper'

describe Admin::ExerciseResultItemsController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/exercise_result_items/batch_action').to({:controller=>"admin/exercise_result_items", :action=>"batch_action"}) } 
	it { should route(:get, '/admin/exercise_result_items').to({:controller=>"admin/exercise_result_items", :action=>"index"}) } 
	it { should route(:get, '/admin/exercise_result_items/new').to({:controller=>"admin/exercise_result_items", :action=>"new"}) } 
	it { should route(:patch, '/admin/exercise_result_items/1').to({:controller=>"admin/exercise_result_items", :action=>"update", :id=>1}) } 
	it { should route(:post, '/admin/exercise_result_items').to({:controller=>"admin/exercise_result_items", :action=>"create"}) } 
	it { should route(:delete, '/admin/exercise_result_items/1').to({:controller=>"admin/exercise_result_items", :action=>"destroy", :id=>1}) } 
	it { should route(:get, '/admin/exercise_result_items/1/edit').to({:controller=>"admin/exercise_result_items", :action=>"edit", :id=>1}) } 
	it { should route(:get, '/admin/exercise_result_items/1').to({:controller=>"admin/exercise_result_items", :action=>"show", :id=>1}) } 
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