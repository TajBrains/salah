class PrayTimeComponent < ApplicationComponent
  def initialize(label:, times: [], is_active: false)
    super
    @label = label
    @times = times.is_a?(Array) ? times : [times]
    @is_active = is_active
  end

  def call
    content_tag :div, class: "pray-time-wrapper", data: data_options do
      label_component + time_component
    end
  end

  private

  def label_component
    content_tag :div, @label, class: "pray-label #{@is_active ? "text-amber-400" : "text-white"}"
  end

  def time_component
    time = @times.first
    content_tag :div, l(time, format: :pray_time), class: "pray-time #{@is_active ? "text-amber-400" : "text-white"}", data: { pray_time_target: "time" }
  end

  def data_options
    if @times.size > 1
      {
        controller: "pray-time",
        pray_time_times_value: @times.map { |time| l(time, format: :pray_time) }
      }
    else
      {}
    end
  end
end
