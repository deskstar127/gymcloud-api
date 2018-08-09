module Services
module Payments
module StripeHandlers

class All

  def call(event)
    log(event)
  end

  private

  def log(event)
    logger.info("STRIPE: #{event.type}: #{event.id}")
    LoggedStripeEvent.create!(
      stripe_event_id: event.id,
      data: event.to_hash
    )
  end

  def logger
    @logger ||= Rails.logger
  end

end

end
end
end
