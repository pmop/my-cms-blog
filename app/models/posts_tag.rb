# frozen_string_literal: true

class PostsTag < ApplicationRecord
  # self.table = 'posts_tags'
  belongs_to :post
  belongs_to :tag

  def self.by_tag_include_post(tag)
    includes(:post, :tag)
      .where(tag: tag)
      .references(:tags)
  end
end
