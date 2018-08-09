module Services
module VideosSearch

class Gymcloud < BaseVideoService

  def input_params
    super.concat([:scope, :user, :order])
  end

  private

  def search
    ::Video
      .send(scope, @user.id)
      .search_by_criteria(@q)
      .send(@order)
      .distinct
      .page(@page).per(@per_page)
  end

  def scope
    {
      mine: :owned_by,
      gymcloud: :public_for
    }[@scope.to_sym]
  end

end

end
end
