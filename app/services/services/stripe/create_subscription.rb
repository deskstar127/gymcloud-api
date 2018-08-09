module Services
module Stripe

class CreateSubscription < BaseService

  def run
    create_subscription
  end

  def input_params
    [:customer]
  end

  private

  def create_subscription
    @customer.subscriptions.create(plan: default_plan.id)
  end

  def default_plan
    plans = ::Stripe::Plan.all
    plan = plans.data.detect { |pl| pl.metadata.default == 'true' }

    plan || create_default_plan
  end

  def create_default_plan
    Services::Seed::StripeDefaultPlan.!
  end

end

end
end
