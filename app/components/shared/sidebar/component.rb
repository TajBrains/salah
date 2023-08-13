# frozen_string_literal: true

class Shared::Sidebar::Component < ApplicationComponent
  # @param [Array] items
  def initialize(items = [])
    @items = items
  end
end
