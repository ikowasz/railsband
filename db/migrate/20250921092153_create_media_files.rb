class CreateMediaFiles < ActiveRecord::Migration[8.0]
  def change
    create_table :media_files, id: :uuid do |t|
      t.references :song, null: false, foreign_key: true, type: :uuid
      t.string :name
      t.json :file
      t.string :checksum

      t.index [MediaFile.column[:song], :checksum], unique: true

      t.timestamps
    end
  end
end
