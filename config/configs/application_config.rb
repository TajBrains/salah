# frozen_string_literal: true

class ApplicationConfig < Anyway::Config
  class << self
    delegate_missing_to :instance

    def instance
      @instance ||= new
    end
  end
end
