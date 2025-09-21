class LyricsAnnotation < ApplicationRecord
  belongs_to :lyrics_version
  belongs_to :media_file, optional: true
  belongs_to :comment, optional: true

  private
    def any_content_presence
      errors.add(:base, "either file or text should be provided") unless media_file.present? or comment.present?
    end
end
