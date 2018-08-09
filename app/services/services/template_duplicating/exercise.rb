module Services
module TemplateDuplicating

class Exercise < BaseService

  def run
    duplicate
  end

  def input_params
    [:exercise, :user, :folder_id]
  end

  def defaults
    {folder_id: nil}
  end

  def build
    ::Exercise.new(prepare_attributes)
  end

  private

  def duplicate
    ::Exercise.create!(prepare_attributes)
  end

  def prepare_attributes
    to_include = %w(name description video_url)
    @exercise.attributes.slice(*to_include).merge(
      is_public: false,
      folder_id: prepare_folder,
      author: @exercise.author,
      user: @user,
      original: @exercise.original || @exercise
    )
  end

  def prepare_folder
    @folder_id ||= ::Folder.find_by(name: 'Exercises', user: @user).id
  end

end

end
end
