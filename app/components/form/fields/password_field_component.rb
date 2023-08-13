module Form
  module Fields
    class PasswordFieldComponent < Form::Fields::BaseComponent
      def call
        form.password_field field.name, class: "input", data: field.data, placeholder: field.placeholder, disabled: field.readonly, autocomplete: field.autocomplete
      end
    end
  end
end
