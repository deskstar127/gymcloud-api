module SearchScopes
module Video

  extend ActiveSupport::Concern

  included do
    scope :owned_by, ->(user_id) { where(author_id: user_id) }
    scope :not_owned_by, ->(user_id) { where.not(author_id: user_id) }
    scope :public_for, (lambda do |user_id|
      not_owned_by(user_id)
        .joins { exercises.outer }
        .joins { workout_templates.outer }
        .where do
          (exercises.is_public == true) | (workout_templates.is_public == true)
        end
    end)
    scope :search_by_criteria, (lambda do |criteria|
      joins { exercises.outer }
      .joins { workout_templates.outer }
      .where do
        query = "%#{my { criteria }}%"
        (name =~ query) |
        (exercises.name =~ query) |
        (exercises.description =~ query) |
        (workout_templates.name =~ query) |
        (workout_templates.description =~ query)
      end
    end)
  end

end
end