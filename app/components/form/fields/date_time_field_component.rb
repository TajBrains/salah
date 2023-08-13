module Form
  module Fields
    class DateTimeFieldComponent < Form::Fields::BaseComponent
      def call
        content_tag :div, class: "w-full", data: data_options do
          form.hidden_field field.name,  value: field.formatted_value, class: 'input',
              data: {
                'date-target': 'input',
                placeholder: field.placeholder
              },
              disabled: field.readonly,
              placeholder: field.placeholder
        end
      end

      private

      def data_options
        {
          controller: "date",
          date_enable_time_value: true,
          date_format_value: field.format,
          date_picker_format_value: field.picker_format,
          date_first_day_of_week_value: field.first_day_of_week,
          date_disable_mobile_value: field.disable_mobile,
          date_picker_options_value: field.picker_options,
          date_time24_hr_value: field.time_24hr,
          date_timezone_value: field.timezone,
          date_relative_value: field.relative,
          date_field_type_value: "dateTime",
        }
      end
    end
  end
end
