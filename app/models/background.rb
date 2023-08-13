class Background < ApplicationRecord
  has_one_attached :image

  jsonb_accessor :metadata,
                 opacity: [:float, { default: 0.8 }],
                 attribute_text: [:string, { default: nil }],
                 attribute_link: [:string, { default: nil }]
end
