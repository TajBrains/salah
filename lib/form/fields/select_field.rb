module Form
  module Fields
    class SelectField < Form::Fields::BaseField
      attr_reader :options_from_args, :display_value, :enum, :multiple, :searchable

      def initialize(id, **args, &block)
        args[:placeholder] ||= I18n.t("form.choose_an_option")

        super(id, **args, &block)

        @options_from_args = process_options(args[:options])
        @enum = args[:enum].present? ? args[:enum] : nil
        @display_value = args[:display_value].present? ? args[:display_value] : false
        @multiple = args[:multiple] || false
        @searchable = args[:searchable] || false
      end

      def include_blank
        case @args[:include_blank]
        when true
          placeholder || "—"
        when false
          false
        else
          @args[:include_blank]
        end
      end

      def options_for_select
        if options.is_a?(Array)
          options
        elsif enum.present?
          display_value ? enum.invert : enum.map { |label, value| [label, label] }.to_h
        elsif display_value
          options.values
        else
          options
        end
      end

      private

      def process_options(options)
        if options.is_a?(Hash)
          ActiveSupport::HashWithIndifferentAccess.new(options)
        else
          options
        end
      end

      def options
        if options_from_args.respond_to?(:call)
          options_from_args.call(model: model, resource: resource, view: view, field: self)
        else
          options_from_args
        end
      end
    end
  end
end
