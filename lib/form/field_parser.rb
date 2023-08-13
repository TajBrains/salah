module Form
  class FieldParser
    attr_reader :type, :args, :name, :block, :instance

    def initialize(name:, **args, &block)
      @name = name
      @type = args.fetch(:type, nil)
      @args = args
      @block = block
      @instance = nil
    end

    def valid?
      instance.present?
    end

    def invalid?
      !valid?
    end

    def parse
      # The symbol can be transformed to a class and found.
      class_name = type.to_s.camelize
      field_class = "Form::Fields::#{class_name}Field"

      # Discover & load custom field classes
      if Object.const_defined? field_class
        @instance = instantiate_field(name, klass: field_class.safe_constantize, **args, &block)
      end

      self
    end

    private

    def instantiate_field(name, klass:, **args, &block)
      if block
        klass.new(name, **args || {}, &block)
      else
        klass.new(name, **args || {})
      end
    end
  end
end
