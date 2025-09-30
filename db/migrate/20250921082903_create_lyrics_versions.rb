class CreateLyricsVersions < ActiveRecord::Migration[8.0]
  def change
    create_table :lyrics_versions, id: :uuid do |t|
      t.references :song, null: false, foreign_key: true, type: :uuid
      t.references :previous_version, null: true, foreign_key: { to_table: :lyrics_versions }, type: :uuid
      t.boolean :is_proposal, default: true
      t.text :lyrics, default: ""
      t.string :description, default: -> { "CONCAT('changes from ', to_char(now(), 'yyyy-mm-dd'))" }

      t.index [ LyricsVersion.column[:song], LyricsVersion.column[:previous_version] ],
        where: "is_proposal = false", unique: true, nulls_not_distinct: true,
        name: "index_lyrics_versions_on_song_and_previous_not_proposal"

      t.timestamps
    end
  end
end
