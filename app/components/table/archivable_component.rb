class Table::ArchivableComponent < Table::TableComponent
  attr_reader :class_name, :show_archived

  def initialize(class_name:, show_archived:)
    @class_name = class_name
    @show_archived = show_archived
  end

  def render?
    class_name.archivable?
  end

  def call
    content_tag :button, button_attributes do
      button_icon + button_text
    end
  end

  private

  def button_attributes
    {
      id: "archive_button",
      class: "dark-button mr-2",
      data: {reflex: "click->#{class_name.to_s.downcase}#toggle_archive_state", value: show_archived}
    }
  end

  def button_icon
    content_tag :i, nil, class: "fa-solid fa-eye mr-1"
  end

  def button_text
    show_archived ? I18n.t('general.archive.hide') : I18n.t('general.archive.show')
  end
end
