class CancelProsSubscribtions < ActiveRecord::Migration

  def up
    pros = ::User.pros.where.not(stripe_customer_id: nil)
    pros.each do |user|
      customer = Services::Stripe::GetCustomer.!(user: user)
      customer.subscriptions.data.each(&:delete)
    end
  end

end
