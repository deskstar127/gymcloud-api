class UpdateSubscriptionWorker

  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily }

  def perform
    ::User.pros.with_stripe.each do |user|
      Services::Stripe::CheckUserSubscription.!(user: user)
    end
  end

end
