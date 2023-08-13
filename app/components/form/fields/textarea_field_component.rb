module Form
  module Fields
    class TextareaFieldComponent < Form::Fields::BaseComponent
      def call
        form.text_area field.name, class: "input", data: field.data, placeholder: field.placeholder,
                                  disabled: field.readonly, required: field.required, value: field.value,
                                  autocomplete: field.autocomplete, rows: field.rows
      end
    end
  end
end
