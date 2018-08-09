module Services

class BaseService

  attr_reader :result

  def self.!(args = {})
    new(args).process.result
  end

  def initialize(args = {})
    define_attributes(args)
    define_defaults
    self
  end

  def process
    @result = run
    self
  end

  private

  def run
    # noop
  end

  def defaults
    {}
  end

  def input_params
    []
  end

  def define_attributes(args)
    input_params.each do |attr_name|
      instance_variable_set(:"@#{attr_name}", args[attr_name])
    end
  end

  def define_defaults
    defaults.each do |attr_name, default_value|
      if instance_variable_get(:"@#{attr_name}").nil?
        instance_variable_set(:"@#{attr_name}", default_value)
      end
    end
  end

end

end
