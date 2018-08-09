module Services
module VideosSearch

class All < BaseVideoService

  def input_params
    super.concat([:scope, :user, :order])
  end

  private

  def search
    attrs = {q: @q, page: @page, per_page: @per_page}
    gc_attrs = attrs.merge(scope: 'gymcloud', user: @user, order: @order)
    mine_attrs = attrs.merge(scope: 'mine', user: @user, order: @order)
    {
      gymcloud: Gymcloud.!(gc_attrs),
      mine: Gymcloud.!(mine_attrs),
      youtube: Youtube.!(attrs),
      vimeo: Vimeo.!(attrs)
    }
  end

end

end
end
