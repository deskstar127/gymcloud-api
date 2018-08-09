module GymcloudAPI::V2
module Entities

class UserProfile < Grape::Entity

  expose :id,
    documentation: {
      desc: 'id',
      type: 'integer',
      required: true
    }

  expose :user_id,
    documentation: {
      desc: 'user id',
      type: 'integer',
      required: true
    }

  expose :first_name,
    documentation: {
      desc: 'first name',
      type: 'string'
    }

  expose :last_name,
    documentation: {
      desc: 'last name',
      type: 'string'
    }

  expose :gender,
    documentation: {
      desc: 'gender',
      type: 'string'
    }

  expose :height,
    documentation: {
      desc: 'height',
      type: 'float'
    }

  expose :weight,
    documentation: {
      desc: 'weight',
      type: 'float'
    }

  expose :bodyfat,
    documentation: {
      desc: 'body fat',
      type: 'float'
    }

  expose :location,
    documentation: {
      desc: 'location',
      type: 'string'
    }

  expose :zip,
    documentation: {
      desc: 'zip code',
      type: 'string'
    }

  expose :employer,
    documentation: {
      desc: 'employer',
      type: 'string'
    }

  expose :birthday,
    documentation: {
      desc: 'birthday',
      type: 'date'
    }

  expose :avatar,
    documentation: {
      desc: 'avatar'
    }

  expose :timezone,
    documentation: {
      desc: 'time zone',
      type: 'string'
    }

end

end
end
