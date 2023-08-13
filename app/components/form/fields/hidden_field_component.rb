module Form
  module Fields
    class HiddenFieldComponent < Form::Fields::BaseComponent
      def call
        form.hidden_field field.name, data: field.data, value: field.value
      end
    end
  end
end
