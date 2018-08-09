module GymcloudAPI
module V2

module GlobalHelpers

  extend Grape::API::Helpers

  def filtered_params
    declared(params, include_missing: false)
      .with_indifferent_access
  end

  def filtered_params_with(attrs = {})
    filtered_params.merge(attrs)
  end

  params :pagination do
    optional :page,     type: Integer, desc: 'Page  number', default: 1
    optional :per_page, type: Integer, desc: 'Items per page'
  end

end

end
end
