module Form
  module Fields
    class PasswordField < Form::Fields::TextField
      def initialize(id, **args, &block)
        super(id, **args, &block)
      end
    end
  end
end
