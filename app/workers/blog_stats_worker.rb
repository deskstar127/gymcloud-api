class BlogStatsWorker

  include Sidekiq::Worker
  include Sidetiq::Schedulable

  sidekiq_options retry: 5 # 15, 16, 31, 96, 271 seconds

  recurrence { hourly(4) }

  def perform
    return unless ENV['WEBHOOK_STATS_KEY'].present?
    connection.post do |request|
      request.url('/webhooks/stats')
      request.headers['Content-Type'] = 'application/json'
      key = {WEBHOOK_STATS_KEY: ENV['WEBHOOK_STATS_KEY']}
      request.body = stats.merge(key).to_json
    end
  end

  private

  def connection
    ::Faraday.new(url: ENV['BLOG_URL']) do |faraday|
      faraday.request(:url_encoded)
      faraday.response(:logger)
      faraday.adapter(::Faraday.default_adapter)
    end
  end

  def stats
    {
      users: ::User.where(is_active: true).count,
      programs: ::ProgramTemplate.where(original_id: nil).count,
      workouts_performed: ::WorkoutEvent.past.count
    }
  end

end