module Services
module Seed

class RootFolderCategory < BaseSeedService

  private

  def klass
    ::RootFolderCategory
  end

  def file_path
    'spec/fixtures/seed/root_folder_category.yml'
  end

end

end
end
