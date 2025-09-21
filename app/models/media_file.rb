class MediaFile < ApplicationRecord
  belongs_to :song
  mount_uploader :file, MediaUploader

  has_many :lyrics_annotation
  has_many :lyrics_version, through: :lyrics_annotation

  attr_readonly :song
  attr_readonly :file
  attr_readonly :checksum

  validates :file, presence: true
  validates_uniqueness_of :checksum, on: :create
  validate :matching_extension, on: :create, if: -> { file.present? }

  before_create :set_default_name
  before_create :compute_checksum

  private
    def matching_extension
      errors.add(:file, "extension doesn't match mime type") unless file.try :valid_mime_type?
    end

    def set_default_name
      self.name = file.try(:filename) if self.name.blank?
    end

    def compute_checksum
      self.checksum = Digest::MD5.hexdigest(file.read)
    end
end
