module Form
  module Fields
    class DateRangeFieldComponent < Form::Fields::BaseComponent
      def call
        content_tag :div, class: "w-full", data: data_options do
          concat start_target_field
          concat end_target_field
          concat input_field
        end
      end

      private

      def start_target_field
        form.hidden_field field.start_target, value: field.formatted_start_value, data: { date_target: 'start' }
      end

      def end_target_field
        form.hidden_field field.end_target, value: field.formatted_end_value, data: { date_target: 'end' }
      end

      def input_field
        hidden_field_tag(nil, nil, class: 'input', data: {date_target: 'input', placeholder: field.placeholder}, disabled: field.readonly, placeholder: field.placeholder)
      end

      def data_options
        {
          controller: "date",
          date_enable_time_value: false,
          date_format_value: field.format,
          date_picker_format_value: field.picker_format,
          date_first_day_of_week_value: field.first_day_of_week,
          date_disable_mobile_value: field.disable_mobile,
          date_field_type_value: "dateRange",
          date_picker_options_value: field.picker_options
        }
      end
    end
  end
end
