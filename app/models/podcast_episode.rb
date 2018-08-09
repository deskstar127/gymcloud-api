# == Schema Information
#
# Table name: podcast_episodes
#
#  id           :integer          not null, primary key
#  title        :string
#  description  :string
#  published_at :datetime
#  file         :string
#  file_size    :integer
#  content_type :string
#  author       :string
#  duration     :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#

class PodcastEpisode < ActiveRecord::Base

  mount_uploader :file, PodcastUploader

  validates :title, :description, :file, :author, :duration, presence: true

  before_save :save_audio_attributes

  scope :published, (lambda do
    where.not(published_at: nil)
      .order(published_at: :desc)
  end)

  private

  def save_audio_attributes
    return if !file.present? && !file_changed?

    self.file_size = file.file.size
    self.content_type = {
      'mp3' => 'audio/mpeg',
      'm4a' => 'audio/x-m4a'
    }[file.file.extension]
  end

end
