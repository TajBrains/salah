module Form
  module Fields
    class TextField < Form::Fields::BaseField
      def initialize(name, **args, &block)
        super(name, **args, &block)
      end
    end
  end
end
