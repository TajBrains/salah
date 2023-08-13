# frozen_string_literal: true

class Table::ItemActions::Component < Table::TableComponent
  renders_one :additional_actions

  def initialize(collection, tag: :td, classes: nil, action: '')
    super
    @collection = collection
    @tag = tag
    @classes = classes
    @action = action
  end

  private

  def archive_reflex_method
    "click->#{@collection.class.to_s.downcase}#toggle_item_archive_state"
  end

  def archivable?
    @collection.class.is_a?(Class) && @collection.class < ActiveRecord::Base && @collection.class.send(:archivable?) && policy([namespace, @collection]).archive?
  end
end
