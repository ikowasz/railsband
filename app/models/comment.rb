class Comment < ApplicationRecord
  belongs_to :song
  has_many :lyrics_annotation
  has_many :lyrics_versions, through: :lyrics_annotation
end
