# frozen_string_literal: true

class PrayTimeService
  attr_reader :pray_time

  PRAY_TIMES_ORDER = %i[fajr dhuhr asr maghrib isha].freeze

  def initialize(pray_time)
    @pray_time = pray_time
  end

  def active?(time)
    index = PRAY_TIMES_ORDER.index(time)

    return false unless index

    @pray_time = PrayTime.yesterday if now.between?(midnight, fajr_time)

    current_pray_time = pray_time.send(time.to_s)
    next_pray_time = time == :isha ? pray_time.tomorrow.fajr : pray_time.send(PRAY_TIMES_ORDER[index + 1])

    Time.current.between?(current_pray_time, next_pray_time)
  end

  def active_time
    @pray_time.send(active_time_name).strftime('%Y-%m-%d %H:%M')
  end

  def next_time
    index = PRAY_TIMES_ORDER.index(active_time_name)

    @pray_time = PrayTime.yesterday if now.between?(midnight, fajr_time)

    active_time_name == :isha ? pray_time.tomorrow.sunset - 30.minutes : pray_time.send(PRAY_TIMES_ORDER[index + 1].to_s)
  end

  def next_time_name
    index = PRAY_TIMES_ORDER.index(active_time_name)
    active_time_name == :isha ? :fajr : PRAY_TIMES_ORDER[index + 1].to_s
  end

  def active_time_name
    PRAY_TIMES_ORDER.find { |time| active?(time) }
  end

  def times
    PRAY_TIMES_ORDER.map { |time| pray_time.send(time).strftime('%Y-%m-%d %H:%M') }
  end

  def times_as_array
    [
      { label: :fajr, times: [pray_time.fajr, pray_time.sunset - 30.minutes], active: active?(:fajr) },
      { label: :sunset, times: pray_time.sunset, active: active?(:sunset) },
      { label: :dhuhr, times: pray_time.dhuhr, active: active?(:dhuhr) },
      { label: :asr, times: pray_time.asr, active: active?(:asr) },
      { label: :maghrib, times: pray_time.maghrib, active: active?(:maghrib) },
      { label: :isha, times: pray_time.isha, active: active?(:isha) }
    ]
  end

  private

  def fajr_time
    fajr_time = DateTime.parse(pray_time.fajr.to_s)
    DateTime.new(fajr_time.year, fajr_time.month, fajr_time.day, fajr_time.hour, fajr_time.minute)
  end

  def now
    now = DateTime.current
    DateTime.new(now.year, now.month, now.day, now.hour, now.minute)
  end

  def midnight
    DateTime.new(now.year, now.month, now.day, 0, 0)
  end
end
