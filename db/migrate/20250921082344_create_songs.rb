class CreateSongs < ActiveRecord::Migration[8.0]
  def change
    create_table :songs, id: :uuid do |t|
      t.string :title

      t.timestamps
    end
  end
end
