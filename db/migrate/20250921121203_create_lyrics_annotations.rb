class CreateLyricsAnnotations < ActiveRecord::Migration[8.0]
  def change
    create_table :lyrics_annotations, id: :uuid do |t|
      t.references :lyrics_version, null: false, foreign_key: true, type: :uuid
      t.references :media_file, null: true, foreign_key: true, type: :uuid
      t.references :comment, null: true, foreign_key: true, type: :uuid
      t.integer :line_start
      t.integer :line_length, default: 1

      t.check_constraint "#{LyricsAnnotation.column[:media_file]} is not null or #{LyricsAnnotation.column[:comment]} is not null"

      t.timestamps
    end
  end
end
