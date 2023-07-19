class PrayTime < ApplicationRecord
	scope :today, -> { find_by(date: Date.current) }
	scope :tomorrow, -> { find_by(date: Date.current + 1.day) }
	scope :yesterday, -> { find_by(date: Date.current - 1.day) }
end
