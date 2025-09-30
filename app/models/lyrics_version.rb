class LyricsVersion < ApplicationRecord
  belongs_to :song
  belongs_to :previous_version, optional: true, class_name: "LyricsVersion"
  has_many :next_versions, ->(lyrics_version) { where(previous_version_id: lyrics_version.id) }, class_name: "LyricsVersion", foreign_key: "previous_version_id", dependent: :restrict_with_error
  has_many :proposals, ->(lyrics_version) { lyrics_version.next_versions.where(is_proposal: 1) }, class_name: "LyricsVersion", foreign_key: "previous_version_id"
  has_one :next_version, ->(lyrics_version) { lyrics_version.next_versions.where(is_proposal: 0) }, class_name: "LyricsVersion", foreign_key: "previous_version_id"
  has_many :lyrics_annotations
  has_many :comments, through: :lyrics_annotations
  has_many :media_files, through: :lyrics_annotations

  validate :was_changed_since_last_refresh, on: [:update, :create]
  before_update :guard_readonly_attributes

  def conflict
    return previous_version.next_version if previous_version.present?
    song.current_lyrics
  end

  def conflict?
    conflict.present?
  end

  private
    def was_changed_since_last_refresh
      errors.add(:previous_version, "lyrics version conflict") if conflict? and !is_proposal
    end

  def guard_readonly_attributes
    if !is_proposal and !just_accepted? and readonly_attributes_changed?
      errors.add(:base, "accepted lyrics are immutable")
      throw :abort
    end
  end

  private
  def just_accepted?
    changes[:is_proposal].present? && changes[:is_proposal][0] == true
  end

  def readonly_attributes_changed?
    (changed_attributes & %w[song_id, previous_version_id, lyrics]).any?
  end
end
