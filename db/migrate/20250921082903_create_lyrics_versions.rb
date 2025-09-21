class CreateLyricsVersions < ActiveRecord::Migration[8.0]
  def change
    create_table :lyrics_versions, id: :uuid do |t|
      t.references :song, null: false, foreign_key: true, type: :uuid
      t.references :previous_version, null: true, foreign_key: { to_table: :lyrics_versions }, type: :uuid
      t.boolean :is_proposal, default: false
      t.text :lyrics, default: ""

      t.timestamps
    end
  end
end
