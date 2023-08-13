module Form
  module Fields
    class DateRangeField < Form::Fields::DateField
      attr_reader :start_target, :end_target

      def initialize(name, **args, &block)
        super(name, **args, &block)

        @start_target = name
        @end_target = args[:end_target] || nil

        raise ArgumentError, "DateRangeField needs an end_target" if @end_target.nil?
      end

      def formatted_start_value
        value = form.record.send(start_target)
        return if value.blank?
        try_iso8601(value)
      end

      def formatted_end_value
        value = form.record.send(end_target)
        return if value.blank?
        try_iso8601(value)
      end

      private

      def try_iso8601(value)
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