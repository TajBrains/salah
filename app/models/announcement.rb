class Announcement < ApplicationRecord
  scope :active, -> { where(active: true) }
end
