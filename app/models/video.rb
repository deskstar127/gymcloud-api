# == Schema Information
#
# Table name: videos
#
#  id                  :integer          not null, primary key
#  vimeo_id            :integer
#  tmp_file            :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  privacy             :integer          default(1)
#  name                :string
#  duration            :integer
#  preview_picture_url :string
#  vimeo_url           :string
#  status              :string
#  embed_url           :string
#  uploaded_at         :datetime
#  author_id           :integer
#

class Video < ActiveRecord::Base

  include SearchScopes::Video

  belongs_to :author, class_name: User
  has_many :exercises, dependent: :nullify
  has_many :workout_templates, dependent: :nullify

  validates :name, length: {maximum: 255}

  scope :oldest, -> { order(uploaded_at: :asc) }
  scope :recent, -> { order(uploaded_at: :desc) }

  mount_uploader :tmp_file, VideoUploader

  before_destroy :delete_tmp_file_folder

  enum privacy: [:anybody, :nobody, :contacts, :password, :disable]

  def available_for_play?
    status == 'available'
  end

  def file_uploaded?
    !vimeo_id.nil?
  end

  def delete_tmp_file_folder
    remove_tmp_file!
    class_name = self.class.to_s.underscore
    path = "#{Rails.root}/public/uploads/#{class_name}/tmp_file/#{id}"
    FileUtils.remove_dir(path, force: true)
  end

end
