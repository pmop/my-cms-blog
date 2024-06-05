# frozen_string_literal: true

class Post < ApplicationRecord
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper

  scope :untagged, -> { includes(:tags).where(tags: { id: nil }) }

  scope :by_tag_include_tag_attrs, ->(tag_permalink) do
    includes(:tags).where(tags: { permalink: tag_permalink})
      .select('tags.name as tag_name, tags.permalink as tag_permalink, posts.*')
  end

  belongs_to :user
  has_rich_text :content

  has_many :posts_tags
  has_many :tags, through: :posts_tags

  before_save do
    self.summary = truncate(strip_tags(content.to_s), length: 300)
  end
end
