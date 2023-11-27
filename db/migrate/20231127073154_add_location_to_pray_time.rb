class AddLocationToPrayTime < ActiveRecord::Migration[7.0]
  def change
    add_column :pray_times, :location, :string
  end
end
