json.extract! lyrics_annotation, :id, :lyrics_version_id, :media_file_id, :comment_id, :line_start, :line_length, :created_at, :updated_at
json.url lyrics_annotation_url(lyrics_annotation, format: :json)
