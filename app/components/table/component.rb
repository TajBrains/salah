# frozen_string_literal: true

class Table::Component < ApplicationComponent
  renders_one :header
  renders_one :body
  renders_one :footer

  attr_reader :class_name, :row_clickable, :pagy

  def initialize(class_name:, row_clickable:, pagy:)
    super
    @class_name = class_name
    @row_clickable = row_clickable
    @pagy = pagy
  end

  def call
    content_tag(:div, class: "data-table") do
      content_tag(:table, class: "table", data: { controller: "table tooltip", isClickable: @row_clickable.to_s }) do
        header.to_s + body_component + footer_component + pagination_component
      end
    end
  end

  private

  def header_component
    header? ? header.to_s : content_tag(:div, nil, class: 'hidden')
  end

  def body_component
    if body?
      content_tag :tbody, body.to_s
    else
      content_tag :tr do
        content_tag(:td, class: "py-2 full-row") do
          content_tag(:h4, "No data was found!", class: "text-center text-gray-600 text-lg")
        end
      end
    end
  end

  def footer_component
    if footer?
      content_tag :tr do
        content_tag(:td, class: "py-2 full-row") do
          footer.to_s
        end
      end
    else
      content_tag(:div, nil, class: 'hidden')
    end
  end

  def pagination_component
    if !pagy.blank? && pagy.pages > 1
      render Table::PaginationComponent.new(pagy: pagy)
    else
      content_tag(:div, nil, class: 'hidden')
    end
  end
end
