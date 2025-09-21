class MediaUploader < CarrierWave::Uploader::Base
  TYPE_EXTENSIONS = {
    image: %w[jpg jpeg gif png webp],
    audio: %w[wav wma wma mp3 mp4 ogg flac aac aiff],
    video: %w[mp4 mov wmv avi mkv flv ogv 3gp vob webm rmvb],
  }

  MEDIA_EXTENSIONS = TYPE_EXTENSIONS.values.flatten
  ALLOWED_CONTENT_TYPES = TYPE_EXTENSIONS.keys.map{ |type| type.to_s + "/" }

  # Include RMagick, MiniMagick, or Vips support:
  # include CarrierWave::RMagick
  # include CarrierWave::MiniMagick
  # include CarrierWave::Vips

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process resize_to_fit: [50, 50]
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg"
  # end

  def extension_allowlist
    MEDIA_EXTENSIONS
  end

  def content_type_allowlist
    ALLOWED_CONTENT_TYPES
  end

  def type
    @type ||= TYPE_EXTENSIONS.keys.detect { |type| content_type.starts_with?(type.to_s + "/") }
  end

  def valid_mime_type?
    TYPE_EXTENSIONS[type].include? file.try(:extension)
  end
end
