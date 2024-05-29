# frozen_string_literal: true

class PostsTag < ApplicationRecord
  # self.table = 'posts_tags'
  belongs_to :post
  belongs_to :tag

  def self.by_tag_permalink_include_post(permalink)
    includes(:post)
      .joins(:tag)
      .where(tags: { permalink: permalink })
      .references(:tags)
  end

  # Objects will include a tag_name attr so we can access
  # the tag's name w/o one extra query
  def self.by_tag_permalink_include_post_tag_name(permalink)
    includes(:post)
      .joins(:post, :tag)
      .select('tags.name AS tag_name, tags.permalink, posts.id, posts_tags.*')
      .where(tags: { permalink: permalink })
  end
end
