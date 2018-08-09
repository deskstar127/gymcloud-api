module Services
module Seed

class StripeDefaultPlan < BaseSeedService

  private

  def create_records_from_fixtures
    id = Date.today.strftime('pro_default_%Y_%m_%d')
    attributes = fixtures.merge(id: id)
    klass.create(attributes)
  end

  def klass
    ::Stripe::Plan
  end

  def file_path
    'spec/fixtures/seed/stripe_default_plan.yml'
  end

end

end
end
