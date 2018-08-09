class CheckTrialWorker

  include Sidekiq::Worker
  include Sidetiq::Schedulable

  recurrence { daily }

  def perform
    users = ::User.pros.where(
      is_trialing: true,
      subscription_end_at: 4.days.from_now..5.days.from_now
    )
    users.each do |user|
      ::HtmlMailer.delay.trial_expiration(user.id)
    end
  end

end