module Form
  class FieldComponent < ApplicationComponent
    attr_reader :form, :field

    def initialize(form:, field:)
      @form = form
      @field = field
    end

    def call
      content_tag :div, class: "grid grid-cols-12 py-1 px-6 border-b border-gray-300 #{field.visible? ? '' : 'hidden'}" do
        concat label
        concat input
      end
    end

    private

    def label
      content_tag :div, class: "col-span-3" do
        form.label field.name, class: "text-sm text-gray-400 uppercase font-bold flex items-center w-full h-full"
      end
    end

    def input
      content_tag :div, class: "col-span-7 flex items-center" do
        render field.view_component.new(form: form, field: field)
      end
    end
  end
end
