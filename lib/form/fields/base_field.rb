module Form
  module Fields
    class BaseField
      attr_reader :type, :name, :options, :block, :required, :readonly, :nullable, :autocomplete, :help, :default, :data, :value, :placeholder

      attr_accessor :form

      def initialize(name, **args, &block)
        @name = name
        @type = args.dig(:type) || :text

        @required = args.dig(:required)
        @readonly = args[:readonly] || false
        @nullable = args[:nullable] || false
        @placeholder = args[:placeholder]
        @autocomplete = args[:autocomplete] || :off
        @help = args.dig(:help)
        @default = args.dig(:default)

        @data = args[:data] || {}
        @value = args[:value] || nil

        @visible = args[:visible] || true

        @block = block
        @args = args
      end

      def view_component
        component_class = "Form::Fields::#{type.to_s.camelize}FieldComponent"
        component_class.constantize
      end

      def value
        @value || form.record.send(name)
      end

      def placeholder
        @placeholder || I18n.t("activerecord.attributes.#{form.record.class.name.underscore}.#{name}")
      end

      def visible?
        @visible || true
      end
    end
  end
end
