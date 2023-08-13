class Table::CellComponent < Table::TableComponent
  with_collection_parameter :column

  def initialize(collection:, tag:, column:, classes: "table_item-cell")
    @collection = collection
    @tag = tag
    @classes = classes

    if column.is_a?(Hash)
      @type = column[:type]
      @column_value = column[:value]
      @column_format = column[:format]
      @column_localize = column[:localize]
    else
      @column_value = column
    end
  end

  def call
    content_tag(@tag, class: @classes) { content(cell_content) }
  end

  def cell_content
    return related_cell_content if @type == :reference
    return custom_cell_content if @type == :custom
    return method_cell_content if @type == :method

    regular_cell_content
  end

  private

  def related_cell_content
    related = @collection.send(@column_value.split(".")[0].to_sym)
    related.send(@column_value.split(".")[1].to_sym) if related.present?
  end

  def custom_cell_content
    @column_value
  end

  def method_cell_content
    @collection.send(@column_value.to_sym)
  end

  def regular_cell_content
    @collection[@column_value.to_sym]
  end

  def content(body)
    return svg_tag :empty, class: "w-6 h-6 fill-black", title: "No data" if body.blank?
    return svg_tag :toggle_on, class: "w-6 h-6 fill-green-700" if body.kind_of?(TrueClass)
    return svg_tag :toggle_off, class: "w-6 h-6 fill-red-700" if body.kind_of?(FalseClass)
    return I18n.l(body, format: @column_format) if @column_localize
    body.to_s
  end
end
