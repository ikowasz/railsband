class Song < ApplicationRecord
  has_many :lyrics_versions, dependent: :restrict_with_error
  has_one :current_lyrics, -> { where(is_proposal: false).order(updated_at: :desc).limit(1) }, class_name: "LyricsVersion", dependent: :restrict_with_error
  has_many :lyrics_history, -> { where(is_proposal: 0).order(updated_at: :desc) }, class_name: "LyricsVersion",  dependent: :restrict_with_error
  has_many :lyrics_history_not_first, ->(song) { song.lyrics_history.where.not(previous_version_id: nil) }, class_name: "LyricsVersion",  dependent: :restrict_with_error
  has_many :lyrics_proposals, -> { where(is_proposal: 1).order(updated_at: :desc) }, class_name: "LyricsVersion",  dependent: :restrict_with_error
  has_many :media_files
  has_many :comments
  has_many :lyrics_annotations, through: :lyrics_history
  has_many :current_lyrics_annotations, through: :current_lyrics, source: :lyrics_annotations, class_name: "LyricsAnnotation", dependent: :restrict_with_error
end
