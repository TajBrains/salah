module Form
  module Fields
    class TextFieldComponent < Form::Fields::BaseComponent
      def call
        form.text_field field.name, class: "input", data: field.data, placeholder: field.placeholder, disabled: field.readonly, required: field.required, value: field.value, autocomplete: field.autocomplete
      end
    end
  end
end
