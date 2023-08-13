module Form
  module Fields
    class SelectFieldComponent < Form::Fields::BaseComponent
      def call
        content_tag :div, class: "w-full", data: data_options do
          form.select field.name,
                      options_for_select(field.options_for_select, selected: field.value),
                      { include_blank: field.include_blank },
                      aria: { placeholder: field.placeholder },
                      data: { select_target: 'input' },
                      class: 'input',
                      disabled: field.readonly,
                      multiple: field.multiple
        end
      end

      private

      def data_options
        {
          controller: connect_controller? ? "select" : "",
          select_multiple_value: field.multiple
        }
      end

      def connect_controller?
        field.multiple || field.searchable
      end
    end
  end
end
