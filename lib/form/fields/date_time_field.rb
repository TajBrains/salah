module Form
  module Fields
    class DateTimeField < Form::Fields::DateField
      attr_reader :time_24hr, :timezone, :relative, :picker_format, :format

      def initialize(id, **args, &block)
        super(id, **args, &block)

        @time_24hr = args[:time_24hr] || true
        @picker_format = args[:picker_format] || "Y-m-d H:i"
        @format = args[:format] || "yyyy-LL-dd TT"
        @timezone = args[:timezone]
        @relative = args[:relative] || true
      end

      def formatted_value
        return nil if value.nil?

        value.utc.to_time.iso8601
      end

      def fill_field(model, key, value, params)
        if value.in?(["", nil])
          model[id] = value

          return model
        end

        return model if value.blank?

        model[id] = utc_time(value)

        model
      end

      def utc_time(value)
        if timezone.present?
          ActiveSupport::TimeZone.new(timezone).local_to_utc(Time.parse(value))
        else
          value
        end
      end

      def timezone
        if @timezone.respond_to?(:call)
          return Avo::Hosts::ResourceViewRecordHost.new(block: @timezone, record: resource.model, resource: resource, view: view).handle
        end

        @timezone
      end
    end
  end
end