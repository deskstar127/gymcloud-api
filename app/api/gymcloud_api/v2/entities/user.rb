module GymcloudAPI::V2
module Entities

class User < Grape::Entity

  expose :id,
    documentation: {
      desc: 'id',
      type: 'integer',
      required: true
    }

  expose :email,
    if: (lambda do |user, options|
      options[:email] && user.live
    end),
    documentation: {
      desc: 'email',
      type: 'string',
      required: true
    }

  expose :live,
    documentation: {
      desc: 'real live user',
      type: 'boolean'
    } \
  do |user|
    user.live
  end

  expose :has_certificate,
    if: -> (user, _) { user.pro? },
    documentation: {
      desc: 'has certificate',
      type: 'boolean'
    } \
  do |user|
    statuses = ::Certificate.statuses
    statuses = [statuses[:verified], statuses[:unverified]]
    user.certificates.where(status: statuses).any?
  end

  expose :unconfirmed_email,
    if: (lambda do |user, options|
      options[:email] && user.unconfirmed_email?
    end),
    documentation: {
      desc: 'unconfirmed_email',
      type: 'string'
    }

  expose :confirmed?,
    as: :is_confirmed,
    documentation: {
      desc: 'is email confirmed?',
      type: 'boolean'
    }

  expose :pro?,
    as: :is_pro,
    documentation: {
      desc: 'professional flag',
      type: 'boolean'
    }

  expose :user_profile,
    using: Entities::UserProfile,
    documentation: {
      desc: 'user profile',
      type: Entities::UserProfile,
      param_type: 'body'
    }

  expose :user_settings,
    using: Entities::UserSettings,
    documentation: {
      desc: 'user settings',
      type: Entities::UserSettings,
      param_type: 'body'
    }

  expose :subscription_end_at,
    documentation: {
      desc: 'subscription end time',
      type: 'datetime'
    }

  expose :is_trialing,
    documentation: {
      desc: 'is trial active?',
      type: 'boolean'
    }

end

end
end
