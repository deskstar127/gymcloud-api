module HasTemplateVersion

  extend ActiveSupport::Concern

  included do

    def self.has_template_version(symbol)

      define_method("source_#{symbol}") do
        record = send(symbol) # workout
        version = send("#{symbol}_version") || 0
        record.try(:versions)&.at(version)&.reify || record
      end

      define_method("set_#{symbol}_version!") do
        version = send(symbol).versions.count
        self.send(:"#{symbol}_version=", version)
      end

      action = "before_create :set_#{symbol}_version!,
                unless: :#{symbol}_version?,
                if: ->(r) {r.send(:#{symbol}).class.name.scan('Template').any?}"

      self.class_eval(action)

    end

  end

end
