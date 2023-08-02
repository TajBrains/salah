class PrayTimeService
  PRAY_TIMES_ORDER = [:fajr, :dhuhr, :asr, :maghrib, :isha].freeze

  def self.is_active?(pray_time, time)
    index = PRAY_TIMES_ORDER.index(time)
    return false unless index

    now = DateTime.now

    if Time.current.between?(DateTime.new(now.year, now.month, now.day, 0, 0), pray_time.fajr)
      pray_time = PrayTime.yesterday
    end

    puts pray_time.inspect
    puts PrayTime.all.inspect
    current_pray_time = pray_time.send(time.to_s)
    next_pray_time = time == :isha ? PrayTime.tomorrow.fajr : pray_time.send(PRAY_TIMES_ORDER[index + 1].to_s)
    # puts
    Time.current.between?(current_pray_time, next_pray_time)
  end

  def self.next_time(pray_time)
    active_time_name = PRAY_TIMES_ORDER.find { |time| PrayTimeService.is_active?(pray_time, time) }
    index = PRAY_TIMES_ORDER.index(active_time_name)

    active_time_name == :isha ? PrayTime.tomorrow.fajr : pray_time.send(PRAY_TIMES_ORDER[index + 1].to_s)
  end

  def self.next_time_name(pray_time)
    active_time_name = PRAY_TIMES_ORDER.find { |time| PrayTimeService.is_active?(pray_time, time) }
    index = PRAY_TIMES_ORDER.index(active_time_name)
    active_time_name == :isha ? :fajr : PRAY_TIMES_ORDER[index + 1].to_s
  end

  def self.active_time(pray_time)
    active_time_name = PRAY_TIMES_ORDER.find { |time| PrayTimeService.is_active?(pray_time, time) }
    pray_time.send(active_time_name)
  end

  def self.times(pray_time)
    PRAY_TIMES_ORDER.map { |time| pray_time.send(time).strftime("%Y-%m-%d %H:%M") }
  end

  def self.times_as_array(pray_time)
    [
      { label: I18n.t("times.fajr"), times: [pray_time.fajr, pray_time.sunset - 30.minutes], is_active: is_active?(pray_time, :fajr) },
      { label: I18n.t("times.sunset"), times: pray_time.sunset, is_active: is_active?(pray_time, :sunset) },
      { label: I18n.t("times.dhuhr"), times: pray_time.dhuhr, is_active: is_active?(pray_time, :dhuhr) },
      { label: I18n.t("times.asr"), times: pray_time.asr, is_active: is_active?(pray_time, :asr) },
      { label: I18n.t("times.maghrib"), times: pray_time.maghrib, is_active: is_active?(pray_time, :maghrib) },
      { label: I18n.t("times.isha"), times: pray_time.isha, is_active: is_active?(pray_time, :isha) }
    ]
  end
end
