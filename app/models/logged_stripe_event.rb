# == Schema Information
#
# Table name: logged_stripe_events
#
#  id              :integer          not null, primary key
#  data            :text
#  stripe_event_id :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class LoggedStripeEvent < ActiveRecord::Base

  serialize :data, Hash

end
