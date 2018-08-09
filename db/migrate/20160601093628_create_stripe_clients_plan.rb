class CreateStripeClientsPlan < ActiveRecord::Migration

  def up
    return unless Stripe.api_key.present?
    name = 'Client Standart Plan'
    plans = Stripe::Plan.all
    if plans.none? { |plan| plan.name == name }
      ::Stripe::Plan.create(
        id: Date.today.strftime('client_standart_%Y_%m_%d'),
        name: name,
        amount: 499,
        currency: 'usd',
        interval: 'month',
        trial_period_days: 14,
        metadata: {default: 'true'}
      )
    end
  end

end
