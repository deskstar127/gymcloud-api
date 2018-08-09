module Services
module Stripe

class CreateCustomer < BaseService

  def run
    create_customer
  end

  def input_params
    [:user]
  end

  private

  def create_customer
    return unless @user.stripe_customer_id.blank?
    raise 'Not confirmed user' unless @user.confirmed?

    customer = ::Stripe::Customer.create(
      email: @user.email,
      metadata: {user_id: @user.id}
    )
    @user.stripe_customer_id = customer.id
    @user.save!
    customer
  end

end

end
end
