module Services
module Stripe

class GetCustomer < BaseService

  def run
    customer
  end

  def input_params
    [:user]
  end

  private

  def customer
    return if @user.stripe_customer_id.blank?
    customer = ::Stripe::Customer.retrieve(@user.stripe_customer_id)
    CheckUserSubscription.!(
      user: @user,
      customer: customer
    )
    customer
  end

end

end
end
