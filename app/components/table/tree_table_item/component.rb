# frozen_string_literal: true

class Table::TreeTableItem::Component < Table::TableComponent
  def initialize(collection, values:, level:, child:, child_add_params:, actions:)
    @values = values
    @collection = collection
    @child = child
    @level = level
    @child_add_params = child_add_params
    @actions = actions
  end

  def accordion_padding_left
    "#{@level * 30 + 20}px"
  end

  def show_child?
    @child && (
      !@child[:collections].nil? && !@child[:collections].empty? ||
      !@child[:access_method].nil? && !@collection.send(@child[:access_method]).empty?
    )
  end

  def child_collections
    @child[:collections] || @collection.send(@child[:access_method])
  end

  def add_params
    @child_add_params.each_with_object({}) do |param, result|
      result[param[:key]] = @collection.send(param[:send_method])
    end
  end

  def render_columns
    render(Table::CellComponent.with_collection(
      @values,
      collection: @collection,
      tag: :div,
      classes: "table_item-cell flex-1 p-0 py-3"
    ))
  end
end
