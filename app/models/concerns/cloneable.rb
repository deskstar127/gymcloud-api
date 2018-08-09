module Cloneable

  extend ActiveSupport::Concern

  included do

    belongs_to :source, polymorphic: true
    has_many :clones, as: :source, class_name: name

  end

end
