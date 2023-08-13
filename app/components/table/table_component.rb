class Table::TableComponent < ApplicationComponent
  include TableHelper
  include Pagy::Frontend
  
  attr_reader :namespace

  def before_render
    @namespace = controller.controller_path.split('/').first.to_sym
  end
end
