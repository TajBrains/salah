# frozen_string_literal: true

class ImportService
  def self.import(location)
    soup = parse_site(location)
    table = soup.css('table.table.vakit-table').last

    times = table.css('tbody tr').map { |tr| tr.css('td').map { |td| td.text.strip } }

    times.each do |time|
      pray_time = PrayTime.find_or_initialize_by(date: Date.strptime(time[0], '%d.%m.%Y'), location: location)
      pray_time.fajr = parse_prayer_time(time[0], time[2])
      pray_time.sunset = parse_prayer_time(time[0], time[3])
      pray_time.dhuhr = parse_prayer_time(time[0], time[4])
      pray_time.asr = parse_prayer_time(time[0], time[5])
      pray_time.maghrib = parse_prayer_time(time[0], time[6])
      pray_time.isha = parse_prayer_time(time[0], time[7])
      pray_time.save
    end
  end

  def self.parse_prayer_time(date_str, time_str)
    DateTime.parse("#{date_str} #{time_str}") - (Time.zone.utc_offset / 3600).hours
  end

  def self.parse_site(location)
    response = HTTParty.get(url_by_location[location.to_sym], headers: user_agent_header)

    Nokogiri::HTML(response.body)
  end

  def self.url_by_location
    {
      mersin: 'https://namazvakitleri.diyanet.gov.tr/en-US/9737/prayer-time-for-mersin',
      stuttgart: 'https://namazvakitleri.diyanet.gov.tr/en-US/11027/prayer-time-for-stuttgart'
    }
  end

  def self.user_agent_header
    {
      'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36'
    }
  end
end
