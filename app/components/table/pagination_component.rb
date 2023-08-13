class Table::PaginationComponent < Table::TableComponent
  def initialize(pagy:)
    @pagy = pagy
  end

  def call
    content_tag :tr do
      content_tag(:td, class: "full-row py-2 px-6") do
        content_tag(:div, class: "flex justify-between items-center") do
          concat(pagy_info(@pagy).html_safe)
          concat(pagy_nav(@pagy).html_safe)
        end
      end
    end
  end
end
