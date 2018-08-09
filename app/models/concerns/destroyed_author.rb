module DestroyedAuthor

  extend ActiveSupport::Concern

  included do

    before_save :check_author

    def check_author
      self.author_id = user_id if author_id.nil?
    end

  end

end
