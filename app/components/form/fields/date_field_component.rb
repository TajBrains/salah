module Form
  module Fields
    class DateFieldComponent < Form::Fields::BaseComponent
      def call
        content_tag :div, class: "w-full", data: data_options do
          form.hidden_field field.name,  value: field.formatted_value, class: 'input',
              data: {
                date_target: 'input',
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
          date_enable_time_value: false,
          date_format_value: field.format,
          date_picker_format_value: @field.picker_format,
          date_first_day_of_week_value: @field.first_day_of_week,
          date_disable_mobile_value: @field.disable_mobile,
          date_field_type_value: "date",
          date_picker_options_value: field.picker_options
        }
      end
    end
  end
end
