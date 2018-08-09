module Services
module VideosSearch

class Youtube < BaseVideoService

  private

  def search
    yt_search = Yt::Collections::Videos.new
    id = id_from_url(@q)
    if id.present?
      yt_search = yt_search.where(id: id)
      yt_search.first
    else
      # only embeddable
      yt_search = yt_search.where(q: @q, format: 5)
    end
    yt_search.first(@per_page * @page).last(@per_page)
  end

  def id_from_url(url)
    match = url.match(%r{youtube.com/watch.*v=([\w\-]*)})
    match ? match[1] : nil
  end

end

end
end
