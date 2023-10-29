# frozen_string_literal: true

class ImportService
  def self.import
    soup = parse_site
    table = soup.css('table.table.vakit-table').last

    times = table.css('tbody tr').map { |tr| tr.css('td').map { |td| td.text.strip } }

    times.each do |time|
      pray_time = PrayTime.find_or_initialize_by(date: Date.strptime(time[0], '%d.%m.%Y'))
      pray_time.fajr = DateTime.parse("#{time[0]} #{time[2]}") - 1.hours
      pray_time.sunset = DateTime.parse("#{time[0]} #{time[3]}") - 1.hours
      pray_time.dhuhr = DateTime.parse("#{time[0]} #{time[4]}") - 1.hours
      pray_time.asr = DateTime.parse("#{time[0]} #{time[5]}") - 1.hours
      pray_time.maghrib = DateTime.parse("#{time[0]} #{time[6]}") - 1.hours
      pray_time.isha = DateTime.parse("#{time[0]} #{time[7]}") - 1.hours
      pray_time.save
    end
  end

  def self.parse_site
    response = HTTParty.get('https://namazvakitleri.diyanet.gov.tr/en-US/11027/prayer-time-for-stuttgart', {
                              headers: {
                                'User-Agent' => 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/109.0.0.0 Safari/537.36'
                              }
                            })

    Nokogiri::HTML(response.body)
  end
end
