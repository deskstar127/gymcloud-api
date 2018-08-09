module MailerHelper

  def webapp_domain
    ENV['DOMAIN_WEBAPP']
  end

  def inivitation_url(token, user)
    params = {
      invitation_token: token,
      first_name: user.user_profile.first_name,
      last_name: user.user_profile.last_name,
      is_pro: user.pro?,
      email: user.email,
      user_id: user.id,
      user_profile_id: user.user_profile.id
    }.to_param
    "http://#{webapp_domain}/#signup?#{params}"
  end

  def personal_program_url(id)
    "http://#{webapp_domain}/#personal_programs/#{id}"
  end

  def personal_workout_url(id)
    "http://#{webapp_domain}/#personal_workouts/#{id}"
  end

  def workout_event_url(date)
    date = date.strftime('%F')
    "http://#{webapp_domain}/#calendar/#{date}"
  end

  def workout_event_results_url(id)
    "http://#{webapp_domain}/#events/#{id}/results"
  end

  def comments_url(id)
    "#{workout_event_results_url(id)}/comments"
  end

  def confirmation_on_frontend(token)
    "http://#{webapp_domain}/#confirm/#{token}"
  end

  def cool_readable_date(date)
    user_local_time(@user, date)
      .strftime('%B %-d, %Y at %I:%M %p')
  end

  def user_local_time(user, time)
    Services::Time.!(user: user, time: time)
  end

end
