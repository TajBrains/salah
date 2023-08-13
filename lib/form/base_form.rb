module Form
  class BaseForm
    class_attribute :fields, default: []
    class_attribute :record, default: nil
    class_attribute :fields_handler
    class_attribute :namespace, default: nil
    class_attribute :title, default: :id
    class_attribute :html_form, default: nil

    def initialize(record, html_form: nil)
      self.class.record = record
      self.class.html_form = html_form
    end

    def self.setup_fields(&block)
      raise "You must provide at least one column to setup columns" unless block_given?
      self.fields_handler = Form::FieldsHandler.new(self)
      yield self.fields_handler if block_given?
    end

    def fields
      fields_handler.fields || []
    end

    def form_title
      return record.send(title) if record.persisted? && record.respond_to?(title)
      return I18n.t("form.new", model: record.class.name) if record.new_record?
      I18n.t("form.edit", model: record.class.name)
    end
  end
end
