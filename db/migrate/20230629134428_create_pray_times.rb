class CreatePrayTimes < ActiveRecord::Migration[7.0]
  def change
    create_table :pray_times do |t|
      t.date :date
      t.datetime :fajr
      t.datetime :sunset
      t.datetime :dhuhr
      t.datetime :asr
      t.datetime :maghrib
      t.datetime :isha
      t.timestamps
    end
  end
end
