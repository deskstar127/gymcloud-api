require 'rails_helper'

describe GoogleOauth2Controller do
  # === Routes (REST) ===
  it { should route(:get, '/users/mobile_auth/google_oauth2/callback').to({:controller=>"google_oauth2", :action=>"mobile_google_oauth2"}) } 
  # === Callbacks (Before) ===
  it { should use_before_filter(:verify_authenticity_token) }
	it { should use_before_filter(:set_paper_trail_enabled_for_controller) }
	it { should use_before_filter(:set_paper_trail_whodunnit) }
	it { should use_before_filter(:set_paper_trail_controller_info) }
  # === Callbacks (After) ===
  it { should use_after_filter(:verify_same_origin_request) }
  # === Callbacks (Around) ===
  
end