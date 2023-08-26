# frozen_string_literal: true

class CreateAnnouncements < ActiveRecord::Migration[7.0]
  def change
    create_table :announcements do |t|
      t.string :title
      t.text :body
      t.integer :show_duration
      t.boolean :active
      t.jsonb :metadata, default: {}
      t.timestamps
    end
  end
end
