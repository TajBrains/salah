FactoryBot.define do
	now = DateTime.current

	factory :pray_time do
		date { now.to_date }
		fajr { DateTime.new(now.year, now.month, now.day, 3, 25) }
		sunset { DateTime.new(now.year, now.month, now.day, 4, 25) }
		dhuhr { DateTime.new(now.year, now.month, now.day, 11, 30) }
		asr { DateTime.new(now.year, now.month, now.day, 15, 20) }
		maghrib { DateTime.new(now.year, now.month, now.day, 18, 30) }
		isha { DateTime.new(now.year, now.month, now.day, 20, 30) }
	end
end
