# frozen_string_literal: true
#
require 'rails_helper'

RSpec.describe PostsTag, type: :model do
  let!(:untagged) { Tag.create(name: 'Untagged', permalink: 'untagged') }
  let!(:setup) do
    u = User.create(
      name:                  'Admin',
      email:                 'admin@test.com',
      password:              '123456',
      password_confirmation: '123456',
      role:                  'admin'
    )
    u.confirm

    p1 = Post.create!(title: 'Untagged post', user: u)
    p2 = Post.create!(title: 'Untagged post', user: u)

    PostsTag.create(post: p1, tag: untagged)
    PostsTag.create(post: p2, tag: untagged)
  end

  describe '.by_tag_includes_post' do
    it 'returns the correct amount of posts' do
      expect(PostsTag.by_tag_permalink_include_post(untagged.permalink)).to have_attributes(size: 2)
    end
  end

  describe '.by_tag_permalink_include_post_tag_name' do
    it 'returns objects that include a tag_name attribute' do
      expect(PostsTag.by_tag_permalink_include_post_tag_name('untagged').first).to have_attributes(tag_name: 'Untagged')
    end
  end
end
