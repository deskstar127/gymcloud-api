class PodcastsController < ApplicationController

  respond_to :rss

  def index
    @episodes = ::PodcastEpisode.published

    respond_to do |format|
      format.rss
      format.json { render json: @episodes }
    end
  end

end
