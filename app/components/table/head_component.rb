class Table::HeadComponent < Table::TableComponent
  def initialize(columns, class_name:, show_actions: true)
    @columns = columns
    @class_name = class_name
    @show_actions = show_actions
  end

  def call
    content_tag :thead, class: "table_head" do
      content_tag :tr do
        table_heads + action_head
      end
    end
  end

  private

  def table_heads
    @columns.map do |column|
      content_tag :th, class: "px-6 py-3 text-left", scope: "col" do
        t("activerecord.attributes.#{@class_name.to_s.underscore}.#{column}")
      end
    end.join.html_safe
  end

  def action_head
    if @show_actions
      content_tag :th, class: "px-6 py-3 text-left", scope: "col" do
        content_tag :span, class: "sr-only" do
          t('general.attributes.actions')
        end
      end
    end
  end
end
