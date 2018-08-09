require 'rails_helper'

describe ConfirmationsController do
  # === Routes (REST) ===
  it { should route(:get, '/users/confirmation').to({:controller=>"confirmations", :action=>"show"}) } 
	it { should route(:get, '/users/confirmation/new').to({:controller=>"confirmations", :action=>"new"}) } 
	it { should route(:post, '/users/confirmation').to({:controller=>"confirmations", :action=>"create"}) } 
  # === Callbacks (Before) ===
  it { should use_before_filter(:assert_is_devise_resource!) }
	it { should use_before_filter(:verify_authenticity_token) }
	it { should use_before_filter(:set_paper_trail_enabled_for_controller) }
	it { should use_before_filter(:set_paper_trail_whodunnit) }
	it { should use_before_filter(:set_paper_trail_controller_info) }
  # === Callbacks (After) ===
  it { should use_after_filter(:verify_same_origin_request) }
  # === Callbacks (Around) ===
  
end