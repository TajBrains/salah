module Form
  module Fields
    class NumberFieldComponent < Form::Fields::BaseComponent
      def call
        form.number_field field.name, class: "input", data: field.data, placeholder: field.placeholder,
                                      disabled: field.readonly, required: field.required, value: field.value,
                                      autocomplete: field.autocomplete, step: field.step, min: field.min, max: field.max
      end
    end
  end
end
