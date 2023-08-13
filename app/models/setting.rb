# frozen_string_literal: true

class Setting < ApplicationRecord
  scope :main, -> {
    find_by(name: 'Main').settings.transform_keys(&:to_sym).transform_values do |value|
      convert_value(value)
    end
  }

  private

  def self.convert_value(value)
    case value
    when 'true'
      true
    when 'false'
      false
    when /\A\d+\z/
      value.to_i
    else
      value
    end
  end
end
