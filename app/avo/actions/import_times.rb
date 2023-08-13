# frozen_string_literal: true
#
class ImportTimes < Avo::BaseAction
  self.name = 'Import'
  # self.visible = -> do
  #   true
  # end

  def handle
    puts 'Hi. I am here'
    succeed 'Success response ✌️'
    warn 'Warning response ✌️'
    inform 'Info response ✌️'
    error 'Error response ✌️'
    ImportService.import
  end
end
