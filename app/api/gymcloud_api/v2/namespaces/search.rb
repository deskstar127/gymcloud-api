module GymcloudAPI::V2
module Namespaces

class Search < Base

namespace :search do

  desc 'Search my library'
  params do
    requires :q, type: String, desc: 'search term'
    optional :entity_type, type: String, default: 'all',
      values: %w(exercises workouts programs clients client_groups all),
      desc: 'item types to search'
    optional :search_scope, type: String, default: 'own',
      values: %w(own public all),
      desc: 'scope search'
  end
  get do
    search = SearchService.new(
      q: filtered_params[:q],
      entity_type: filtered_params[:entity_type],
      search_scope: filtered_params[:search_scope],
      user_id: current_user.id
    )
    search.search!
    results = search.results.dup

    results.map do |group|
      presenter_class = [
        'GymcloudAPI::V2::Entities',
        group[:klass]
      ].join('::').constantize
      group[:items] = presenter_class.represent(group[:items])
    end

    present results
  end

end

end

end
end
