# frozen_string_literal: true

FactoryBot.define do
  factory :pray_time do
    trait :tomorrow do
      tomorrow = Date.current + 1.day
      date { tomorrow }
      fajr { DateTime.new(tomorrow.year, tomorrow.month, tomorrow.day, 3, 25) }
      sunset { DateTime.new(tomorrow.year, tomorrow.month, tomorrow.day, 5, 25) }
      dhuhr { DateTime.new(tomorrow.year, tomorrow.month, tomorrow.day, 11, 30) }
      asr { DateTime.new(tomorrow.year, tomorrow.month, tomorrow.day, 15, 20) }
      maghrib { DateTime.new(tomorrow.year, tomorrow.month, tomorrow.day, 18, 30) }
      isha { DateTime.new(tomorrow.year, tomorrow.month, tomorrow.day, 20, 30) }
    end

    trait :yesterday do
      yesterday = Date.current - 1.day
      date { yesterday }
      fajr { DateTime.new(yesterday.year, yesterday.month, yesterday.day, 3, 25) }
      sunset { DateTime.new(yesterday.year, yesterday.month, yesterday.day, 5, 25) }
      dhuhr { DateTime.new(yesterday.year, yesterday.month, yesterday.day, 11, 30) }
      asr { DateTime.new(yesterday.year, yesterday.month, yesterday.day, 15, 20) }
      maghrib { DateTime.new(yesterday.year, yesterday.month, yesterday.day, 18, 30) }
      isha { DateTime.new(yesterday.year, yesterday.month, yesterday.day, 20, 30) }
    end

    now = Date.current

    date { now.to_date }
    fajr { DateTime.new(now.year, now.month, now.day, 3, 25) }
    sunset { DateTime.new(now.year, now.month, now.day, 5, 25) }
    dhuhr { DateTime.new(now.year, now.month, now.day, 11, 30) }
    asr { DateTime.new(now.year, now.month, now.day, 15, 20) }
    maghrib { DateTime.new(now.year, now.month, now.day, 18, 30) }
    isha { DateTime.new(now.year, now.month, now.day, 20, 30) }
  end
end
