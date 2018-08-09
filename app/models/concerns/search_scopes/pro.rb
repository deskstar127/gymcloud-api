module SearchScopes
module Pro

  extend ActiveSupport::Concern

  included do
    scope :owned_by, ->(id) { find(id).clients }
    scope :public_for, ->(id) { owned_by(id) }
    scope :global_for, ->(id) { owned_by(id) }
    scope :search_by_criteria, (lambda do |criteria|
      joins { user_profile }
        .where do
          (user_profile.first_name =~ my { criteria }) |
          (user_profile.last_name =~ my { criteria }) |
          (concat(user_profile.first_name, ' ', user_profile.last_name) =~
            my { criteria })
        end
    end)
  end

end
end
