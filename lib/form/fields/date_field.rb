module Form
  module Fields
    class DateField < Form::Fields::BaseField
      attr_reader :first_day_of_week
      attr_reader :picker_format
      attr_reader :disable_mobile
      attr_reader :format
      attr_reader :picker_options

      def initialize(name, **args, &block)
        super(name, **args, &block)

        @first_day_of_week = args[:first_day_of_week] || 1
        @picker_format = args[:picker_format] || "Y-m-d"
        @disable_mobile = args[:disable_mobile] || false
        @picker_options = args[:picker_options] || {}
      end

      def formatted_value
        return if value.blank?

        try_iso8601
      end

      private

      def try_iso8601
        if value.respond_to?(:iso8601)
          value.iso8601
        elsif value.is_a?(String)
          parsed = DateTime.parse(value.dup)
          if parsed.present?
            parsed
          end
        else
          value
        end
      end
    end
  end
end