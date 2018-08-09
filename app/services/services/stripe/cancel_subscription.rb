module Services
module Stripe

class CancelSubscription < BaseService

  def run
    delete
  end

  def input_params
    [:user, :id]
  end

  private

  def delete
    customer = GetCustomer.!(user: @user)
    subscription = customer.subscriptions.retrieve(@id)
    subscription.delete
    @user.update_attribute(:subscription_end_at, ::DateTime.now)

    subscription
  end

end

end
end
