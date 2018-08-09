title = 'The Gym Cloud Podcast: Breaking Down Barriers To Better Fitness'
author = 'Gym Cloud - Online Fitness Training Solutions'
email = 'support@gymcloud.com'
description = 'We empower fitness professionals with tools and knowledge to
  become better coaches and help more people.'
keywords = 'GymCloud, podcasts, training, workouts'
image = 'https://api.gymcloud.com/podcast_cover.jpg'

xml.rss(
  'xmlns:itunes' => 'http://www.itunes.com/dtds/podcast-1.0.dtd',
  'xmlns:media' => 'http://search.yahoo.com/mrss/',
  version: '2.0'
) do
  xml.channel do
    xml.title title
    xml.link 'https://www.gymcloud.com/'
    xml.description description
    xml.language 'en'
    xml.pubDate @episodes.first.published_at.to_s(:rfc822)
    xml.lastBuildDate @episodes.first.published_at.to_s(:rfc822)
    xml.itunes :author, author
    xml.itunes :keywords, keywords
    xml.itunes :explicit, 'clean'
    xml.itunes :image, href: image
    xml.itunes :owner do
      xml.itunes :name, author
      xml.itunes :email, email
    end
    xml.itunes :block, 'no'
    xml.itunes :category, text: 'Health' do
      xml.itunes :category, text: 'Fitness & Nutrition'
    end

    @episodes.each do |episode|
      xml.item do
        xml.title episode.title
        xml.description episode.description
        xml.pubDate episode.published_at.to_s(:rfc822)
        xml.enclosure(
          url: episode.file.url,
          length: episode.file_size,
          type: episode.content_type
        )
        xml.link episode.file.url
        xml.guid episode.id
        xml.itunes :author, episode.author
        xml.itunes :subtitle, truncate(episode.description, length: 150)
        xml.itunes :summary, episode.description
        xml.itunes :explicit, 'no'
        xml.itunes :duration, episode.duration
      end
    end
  end
end