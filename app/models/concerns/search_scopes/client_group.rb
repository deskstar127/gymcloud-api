module SearchScopes
module ClientGroup

  extend ActiveSupport::Concern

  included do
    scope :owned_by, ->(id) { where(pro_id: id) }
    scope :public_for, ->(_id) { nil }
    scope :global_for, ->(id) { owned_by(id) }
    scope :search_by_criteria, (lambda do |criteria|
      where { name =~ my { criteria } }
    end)
  end

end
end
