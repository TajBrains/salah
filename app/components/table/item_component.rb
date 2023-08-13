# frozen_string_literal: true

class Table::ItemComponent < Table::TableComponent
  renders_one :additional_action

  def initialize(collection, values:, actions: {}, column_tag: :td)
    super
    @collection = collection

    @values = values
    @column_tag = column_tag
    @actions = actions
  end

  def call
    content_tag(:tr, class: "table_row", data: {url: edit_url}) do
      render_cells + render_actions
    end
  end

  private

  def edit_url
    if !@actions.nil? && @collection.class.is_a?(Class) && @collection.class < ActiveRecord::Base
      return edit_polymorphic_url([namespace, @collection])
    end

    false
  end

  def render_cells
    render(Table::CellComponent.with_collection(@values,
      collection: @collection,
      tag: @column_tag,
    ))
  end

  def render_actions
    unless @actions.nil?
      render(Table::ItemActions::Component.new(@collection,
        tag: @column_tag,
        classes: @actions[:classes],
        action: additional_action
      ))
    end
  end
end
