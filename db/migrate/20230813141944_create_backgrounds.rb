class CreateBackgrounds < ActiveRecord::Migration[7.0]
  def change
    create_table :backgrounds do |t|
      t.string :name
      t.string :key, null: false, unique: true, index: true
      t.jsonb :metadata, default: {}
      t.timestamps
    end
  end
end
