module Form
  module Fields
    class BooleanField < Form::Fields::BaseField
      attr_reader :true_value
      attr_reader :false_value

      def initialize(name, **args, &block)
        super(name, **args, &block)

        @true_value = args[:true_value].present? ? args[:true_value] : true
        @false_value = args[:false_value].present? ? args[:false_value] : false
      end

      def truthy_values
        ["true", "1", @true_value]
      end

      def falsy_values
        ["false", "0", @false_value]
      end
    end
  end
end
