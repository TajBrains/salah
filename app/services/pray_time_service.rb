# frozen_string_literal: true

class PrayTimeService
  attr_reader :praytime

  PRAY_TIMES_ORDER = %i[fajr fajr_iqamah dhuhr asr maghrib isha].freeze

  def initialize(praytime, location)
    @praytime = praytime
    @location = location
  end

  def active?(time)
    index = PRAY_TIMES_ORDER.index(time)
    return false unless index

    current_pray_time, next_pray_time = calculate_pray_times(time, index)

    Time.current.between?(current_pray_time, next_pray_time)
  end

  def active_time
    @praytime.send(active_time_name).strftime('%Y-%m-%d %H:%M')
  end

  def next_time
    index = PRAY_TIMES_ORDER.index(active_time_name)

    _, next_pray_time = calculate_pray_times(active_time_name, index)

    next_pray_time
  end

  def next_time_name
    index = PRAY_TIMES_ORDER.index(active_time_name)
    active_time_name == :isha ? :fajr : PRAY_TIMES_ORDER[index + 1].to_s
  end

  def active_time_name
    PRAY_TIMES_ORDER.find { |time| active?(time) }
  end

  def times
    PRAY_TIMES_ORDER.map { |time| praytime.send(time).strftime('%Y-%m-%d %H:%M') }
  end

  def times_as_array
    [
      { label: :fajr, times: [praytime.fajr, praytime.fajr_iqamah], active: active?(:fajr) || active?(:fajr_iqamah) },
      { label: :sunset, times: praytime.sunset, active: false },
      { label: :dhuhr, times: praytime.dhuhr, active: active?(:dhuhr) },
      { label: :asr, times: praytime.asr, active: active?(:asr) },
      { label: :maghrib, times: praytime.maghrib, active: active?(:maghrib) },
      { label: :isha, times: praytime.isha, active: active?(:isha) }
    ]
  end

  private

  def calculate_pray_times(time, index)
    pt = now.between?(midnight, fajr_time) && time == :isha ? PrayTime.for_location(@location).yesterday : @praytime

    current_pray_time = pt.send(PRAY_TIMES_ORDER[index])
    next_pray_time = time == :isha ? pt.tomorrow.fajr : pt.send(PRAY_TIMES_ORDER[index + 1])

    [current_pray_time, next_pray_time]
  end

  def fajr_time
    fajr_time = @praytime.fajr
    Time.new(fajr_time.year, fajr_time.month, fajr_time.day, fajr_time.hour, fajr_time.min)
  end

  def now
    now = Time.current
    Time.new(now.year, now.month, now.day, now.hour, now.min)
  end

  def midnight
    Time.new(now.year, now.month, now.day, 0, 0)
  end
end
