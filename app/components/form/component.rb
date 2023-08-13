module Form
  class Component < ApplicationComponent
    attr_reader :form

    def initialize(form:)
      @form = form
    end

    def call
      if form.html_form.blank?
        form_for [form.namespace, form.record] do |f|
          head(f) + fields(f)
        end
      else
        head(form.html_form) + fields(form.html_form)
      end
    end

    private

    def head(f)
      content_tag :div, class: 'flex items-center justify-between mb-2' do
        title + buttons
      end
    end

    def title
      content_tag :h2, form.form_title, class: 'text-2xl font-bold'
    end

    def buttons
      content_tag :div, class: 'flex items-center justify-end mb-2' do
        content_tag :button, type: "submit", class: "dark-button flex items-center" do
          concat content_tag(:i, nil, class: "fas fa-save mr-2")
          concat t('general.save')
        end
      end
    end

    def fields(f)
      content_tag :div, class: 'bg-white rounded-lg overflow-hidden shadow-lg' do
        form.fields.map do |field|
          render Form::FieldComponent.new(form: f, field: field)
        end.join.html_safe
      end
    end
  end
end
