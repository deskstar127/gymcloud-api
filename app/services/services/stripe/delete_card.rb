module Services
module Stripe

class DeleteCard < BaseService

  def run
    delete
  end

  def input_params
    [:user, :id]
  end

  private

  def delete
    customer.sources.retrieve(@id).delete
  end

  def customer
    @customer ||= ::Stripe::Customer.retrieve(@user.stripe_customer_id)
  end

end

end
end
