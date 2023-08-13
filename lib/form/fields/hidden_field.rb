module Form
  module Fields
    class HiddenField < Form::Fields::BaseField
      def initialize(name, **args, &block)
        super(name, **args, &block)
      end

      def visible?
        false
      end
    end
  end
end
