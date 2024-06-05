# frozen_string_literal: true

module TagsHelper
  def virtual_untagged_tag
    virtual_tag('Untagged', 'untagged')
  end

  def virtual_tag(name, permalink)
    OpenStruct.new(name:, permalink:)
  end
end
