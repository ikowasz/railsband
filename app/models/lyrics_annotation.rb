class LyricsAnnotation < ApplicationRecord
  belongs_to :lyrics_version
  belongs_to :media_file, optional: true
  belongs_to :comment, optional: true
  has_one :song, through: :lyrics_version

  private
    def any_content_presence
      errors.add(:base, "either file or text should be provided") unless media_file.present? or comment.present?
    end
end
