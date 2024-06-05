require 'rails_helper'

RSpec.describe Post, type: :model do
  let!(:admin) { create(:admin_user) }
  let(:tags) do
    ['Ruby on Rails', 'Databases', 'Misc'].map do |name|
      Tag.create!(name: name, permalink: name.downcase.tr(' ', '-'))
    end
  end

  let(:posts) do
    tags_w_no_tag = [nil, *tags]

    posts = build_list(:post, 11) do |post|
      post.title     = Faker::Book.title
      post.permalink = post.title.downcase.tr(' ', '-')
      post.user      = admin
    end.each(&:save!)

    posts.each_with_index do |post, i|
      tag = tags_w_no_tag[i%4]
      post.tags.push(tag) if tag.present?
    end

    posts
  end

  describe '.untagged' do
    let(:expected_result) do
      Post.includes(:tags).where(tags: { id: nil })
    end

    before { posts }

    it 'returns the expected posts' do
      expect(Post.untagged).to eq(expected_result)
    end
  end

  describe '.by_tag_include_tag_attrs' do
    let(:tag_permalink) { 'ruby-on-rails' }
    # TODO: can be improved
    let(:expected_result) do
      Post.includes(:tags)
          .where(tags: { permalink: tag_permalink })
          .select('tags.name as tag_name, tags.permalink as tag_permalink, posts.*')
    end

    it 'returns the expected posts' do
      expect(Post.by_tag_include_tag_attrs(tag_permalink)).to eq(expected_result)
    end
  end
end
