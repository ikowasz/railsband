class MediaFile < ApplicationRecord
  belongs_to :song
  mount_uploader :file, MediaUploader
  has_many :lyrics_annotation
  has_many :lyrics_version, through: :lyrics_annotation

  validates :file, presence: true
  validate :matching_extension, on: :create, if: -> { file.present? }
  before_create :set_default_name

  private
    def matching_extension
      errors.add(:file, "extension doesn't match mime type") unless file.try :valid_mime_type?
    end

    def set_default_name
      self.name = file.try(:filename) if self.name.blank?
    end
end
