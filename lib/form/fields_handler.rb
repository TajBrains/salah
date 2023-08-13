module Form
  class FieldsHandler
    attr_reader :fields, :form

    def initialize(form)
      @form = form
      @fields = []
    end

    def field(name, **args, &block)
      field_parser = Form::FieldParser.new(name: name, **args, &block).parse
  
      if field_parser.invalid?
        type = args.fetch(:type, nil)
  
        raise ArgumentError, "Invalid field type :#{type} for field: #{name}"
      end
      
      field_parser.instance.form = form
      fields << field_parser.instance
    end
  end
end
