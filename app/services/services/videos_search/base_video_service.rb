module Services
module VideosSearch

class BaseVideoService < BaseService

  def run
    search
  end

  def input_params
    [:q, :page, :per_page]
  end

  def defaults
    {per_page: 50, page: 1}
  end

end

end
end
