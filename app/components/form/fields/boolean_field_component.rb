module Form
  module Fields
    class BooleanFieldComponent < Form::Fields::BaseComponent
      def call
        content_tag :div, class: "w-5 h-full my-2 flex items-center" do
          form.check_box field.name, class: "input border-2 border-gray-300", checked: field.value, data: field.data, placeholder: field.placeholder, disabled: field.readonly, autocomplete: field.autocomplete
        end
      end
    end
  end
end
