require 'rails_helper'

describe Admin::PropertyUnitsController do
  # === Routes (REST) ===
  it { should route(:post, '/admin/property_units/batch_action').to({:controller=>"admin/property_units", :action=>"batch_action"}) } 
	it { should route(:get, '/admin/property_units').to({:controller=>"admin/property_units", :action=>"index"}) } 
	it { should route(:get, '/admin/property_units/new').to({:controller=>"admin/property_units", :action=>"new"}) } 
	it { should route(:patch, '/admin/property_units/1').to({:controller=>"admin/property_units", :action=>"update", :id=>1}) } 
	it { should route(:post, '/admin/property_units').to({:controller=>"admin/property_units", :action=>"create"}) } 
	it { should route(:delete, '/admin/property_units/1').to({:controller=>"admin/property_units", :action=>"destroy", :id=>1}) } 
	it { should route(:get, '/admin/property_units/1/edit').to({:controller=>"admin/property_units", :action=>"edit", :id=>1}) } 
	it { should route(:get, '/admin/property_units/1').to({:controller=>"admin/property_units", :action=>"show", :id=>1}) } 
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