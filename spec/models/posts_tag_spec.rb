require 'rails_helper'

RSpec.describe PostsTag, type: :model do
  describe '.by_tag_includes_post' do
    let!(:untagged) { Tag.create(name: 'Untagged', permalink: 'untagged') }

    before do
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


    it 'returns the correct amount of posts' do
      expect(PostsTag.by_tag_include_post(untagged)).to have_attributes(size: 2)
    end
  end
end
