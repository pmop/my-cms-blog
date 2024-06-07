# frozen_string_literal: true

module TagsHelper
  def virtual_untagged_tag
    @@virtual_untagged_tag ||= virtual_tag('Untagged', 'untagged')
  end

  def virtual_tag(name, permalink)
    OpenStruct.new(name:, permalink:)
  end

  def virtual_tag_for(post, permalink)
    return nil if !post.present?

    return virtual_untagged_tag if permalink == virtual_untagged_tag.permalink

    virtual_tag(post.tag_name, post.tag_permalink)
  end

  def sanitize_tag_permalink(input)
    input&.strip&.first(25)&.tr('^[a-z-]', '')
  end
end
