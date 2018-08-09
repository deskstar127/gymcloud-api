module SearchScopes
module Training

  MASTER_EMAILS = (ENV['MASTER_EMAIL'] || ['support@gymcloud.com']).freeze

  extend ActiveSupport::Concern

  included do

    scope :owned_by, ->(id) { where(user_id: id) }

    scope :not_owned_by, ->(id) { where.not(user_id: id) }

    scope :owned_by_master, (lambda do
      joins(:user)
        .where(users: {email: MASTER_EMAILS})
    end)

    scope :public_for_by_master, (lambda do |id|
      not_owned_by(id)
        .owned_by_master
        .where(is_public: true)
    end)

    scope :public_for_by_all, ->(id) { not_owned_by(id).where(is_public: true) }

    scope :global_for_by_master, (lambda do |id|
      joins(:user)
        .where do
          (users.email >> my { MASTER_EMAILS }) & (is_public == true) |
          (user_id == my { id })
        end
    end)

    scope :global_for_by_all, (lambda do |id|
      where { (user_id == my { id }) | (is_public == true) }
    end)

    scope :search_by_criteria, (lambda do |criteria|
      where { name =~ my { criteria } }
    end)

    class << self
      alias_method :public_for, :public_for_by_master
      alias_method :global_for, :global_for_by_master
    end

  end

end
end
