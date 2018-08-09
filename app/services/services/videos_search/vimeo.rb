module Services
module VideosSearch

class Vimeo < BaseVideoService

  def run
    @result = []
    @collection = nil
    super
  end

  private

  def search
    collection = client.search_videos(
      @q,
      page: @page,
      per_page: @per_page
    )
    @result = filter_results(collection.items)
  end

  def search_with_filtered
    response = make_request
    items = response.try(:items) || response
    filtered = filter_results(items)
    @result.concat filtered

    if @result.count < @page * @per_page
      search_with_filtered
    else
      @result.last(@per_page)
    end
  end

  def make_request
    if @collection.nil?
      @collection = client.search_videos(
        @q,
        page: 1,
        per_page: 50 # vimeo maximum
      )
    else
      @collection.next_page
    end
  end

  def filter_results(results)
    results.reject { |v| v.embed.html.nil? }
  end

  def client
    @client ||=
      ::Vimeo::Client.new(access_token: ENV['VIMEO_TOKEN'])
  end

end

end
end
