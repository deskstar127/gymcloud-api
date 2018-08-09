module GymcloudAPI::V2
module Entities

class UserAgreement < Grape::Entity

  expose :id,
    documentation: {
      desc: 'id',
      type: 'integer',
      required: true
    }

  expose :created_at
  expose :updated_at

  expose :pro_id,
    documentation: {
      desc: 'pro_id',
      type: 'integer',
      required: true
    }

  expose :client_id,
    documentation: {
      desc: 'client_id',
      type: 'integer',
      required: true
    }

  expose :category_id,
    documentation: {
      desc: 'category_id',
      type: 'integer',
      required: true
    }

  expose :status,
    documentation: {
      desc: 'status',
      type: 'string',
      required: true
    }

end

end
end
