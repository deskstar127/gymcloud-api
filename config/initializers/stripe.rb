Stripe.api_key = ENV['STRIPE_SECRET_KEY']

StripeEvent.configure do |events|

  events.all Services::Payments::StripeHandlers::All.new

end
