# frozen_string_literal: true

class Table::TreeTableComponent < ApplicationComponent
  renders_many :items, -> (collection, values:, level: 0, child: nil, child_add_params: [], actions: true) do
    Table::TreeTableItem::Component.new(
      collection,
      values: values,
      level: level,
      child: child,
      child_add_params: child_add_params,
      actions: actions,
    )
  end

  def call
    accordion class: "shadow-xl bg-white rounded-xl overflow-auto", data: {controller: "tooltip"} do
      items.join.html_safe
    end
  end
end
