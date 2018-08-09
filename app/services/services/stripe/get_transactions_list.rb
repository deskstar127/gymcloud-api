module Services
module Stripe

class GetTransactionsList < BaseService

  def run
    list
  end

  def input_params
    [:user, :starting_after, :limit]
  end

  def defaults
    {limit: 10, starting_after: nil}
  end

  private

  def list
    return [] if @user.stripe_customer_id.blank?
    charges.data
  end

  def charges
    ::Stripe::Charge.all(params)
  end

  def params
    {
      customer: @user.stripe_customer_id,
      limit: @limit,
      starting_after: @starting_after
    }.compact
  end

end

end
end
