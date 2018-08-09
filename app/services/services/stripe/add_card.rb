module Services
module Stripe

class AddCard < BaseService

  def run
    add
  end

  def input_params
    [:user, :id]
  end

  private

  def add
    customer.sources.create(source: @id)
  end

  def customer
    @customer ||= ::Stripe::Customer.retrieve(@user.stripe_customer_id)
  end

end

end
end
