# frozen_string_literal: true

class Post < ApplicationRecord
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper

  scope :untagged, -> { includes(:tags).where(tags: { id: nil }) }

  belongs_to :user
  has_rich_text :content

  has_many :posts_tags
  has_many :tags, through: :posts_tags

  before_save do
    self.summary = truncate(strip_tags(content.to_s), length: 300)
  end
end
