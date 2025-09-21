json.extract! media_file, :id, :song_id, :file, :name, :created_at, :updated_at
json.url media_file_url(media_file, format: :json)
