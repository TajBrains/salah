# frozen_string_literal: true

class PrayTime < ApplicationRecord
  validates :date, presence: true, uniqueness: { scope: :location }
  validates :location, presence: true

  def self.for_location(location)
    where(location: location)
  end

  def self.today
    find_by(date: Date.current)
  end

  def self.tomorrow
    find_by(date: Date.current + 1.day)
  end

  def tomorrow
    PrayTime.find_by(date: date + 1.day)
  end

  def self.yesterday
    find_by(date: Date.current - 1.day)
  end

  def fajr_iqamah
    sunset - 30.minutes
  end

  def to_s
    "<PrayTime id: #{id}, date: #{date}>"
  end
end
