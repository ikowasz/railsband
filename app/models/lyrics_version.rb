class LyricsVersion < ApplicationRecord
  belongs_to :song
  belongs_to :previous_version, optional: true, class_name: "LyricsVersion"
end
