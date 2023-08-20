# frozen_string_literal: true

class PrayTimeComponent < ApplicationComponent
  def initialize(label:, times: [], active: false)
    super
    @label = label
    @times = times.is_a?(Array) ? times : [times]
    @active = active
  end

  def call
    content_tag :div, class: 'pray-time-wrapper', data: data_options do
      label_component + time_component
    end
  end

  private

  def label_component
    content_tag :div, "#{t("times.#{@label}", locale: :tr)}/#{t("times.#{@label}", locale: :de)}",
                class: "pray-label #{@active ? 'text-amber-400' : 'text-white'}"
  end

  def time_component
    time = @times.first
    content_tag :div, l(time, format: :pray_time), class: "pray-time #{@active ? 'text-amber-400' : 'text-white'}",
                                                   data: { pray_time_target: 'time' }
  end

  def data_options
    if @times.size > 1
      {
        controller: 'pray-time',
        pray_time_times_value: @times.map { |time| l(time, format: :pray_time) }
      }
    else
      {}
    end
  end
end
