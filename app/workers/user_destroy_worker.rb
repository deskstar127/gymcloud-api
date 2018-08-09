class UserDestroyWorker

  include Sidekiq::Worker

  sidekiq_options retry: 5

  def perform(user_id)
    user = User.find(user_id)
    Services::UserDestroy::All.!(user: user)
  end

end
