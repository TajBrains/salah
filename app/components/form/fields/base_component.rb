# frozen_string_literal: true

class Form::Fields::BaseComponent < ApplicationComponent
  attr_reader :field, :form

  def initialize(field: nil, form: nil, **kwargs)
    @field = field
    @form = form
  end

end
