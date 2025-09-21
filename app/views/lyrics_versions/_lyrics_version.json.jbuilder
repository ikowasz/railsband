json.extract! lyrics_version, :id, :song_id, :previous_version_id, :is_proposal, :lyrics, :created_at, :updated_at
json.url lyrics_version_url(lyrics_version, format: :json)
