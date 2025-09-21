class MediaFile < ApplicationRecord
  belongs_to :song
  mount_uploader :uploader, MediaUploader

  has_many :lyrics_annotation
  has_many :lyrics_version, through: :lyrics_annotation

  attr_readonly :song
  attr_readonly :uploader
  attr_readonly :checksum

  validates :uploader, presence: true
  validates_uniqueness_of :checksum, on: :create
  validate :matching_extension, on: :create, if: -> { uploader.present? }

  before_create :set_default_name
  before_create :compute_checksum
  before_destroy :remove_file

  private
    def matching_extension
      errors.add(:uploader, "extension doesn't match mime type") unless uploader.try :valid_mime_type?
    end

    def set_default_name
      self.name = uploader.try(:filename) if self.name.blank?
    end

    def compute_checksum
      self.checksum = Digest::MD5.hexdigest(uploader.read)
    end

    def remove_file
      uploader.file.delete
    end
end
