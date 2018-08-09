class DisableProsTrialPeriods < ActiveRecord::Migration

  def up
    ::User
      .pros
      .where.not(stripe_customer_id: nil)
      .update_all('subscription_end_at = NULL, is_trialing = NULL')
  end

end
