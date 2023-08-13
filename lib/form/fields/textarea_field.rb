module Form
  module Fields
    class TextareaField < Form::Fields::TextField
      attr_reader :rows

      def initialize(id, **args, &block)
        super(id, **args, &block)

        @rows = args[:rows].present? ? args[:rows].to_i : 4
      end
    end
  end
end
