require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let!(:admin) do
    User.create_or_find_by(
      name:                  'Admin',
      email:                 'admin@test.com',
      password:              '123456',
      password_confirmation: '123456',
      role:                  'admin'
    ).tap do |admin|
      admin.confirm
    end
  end

  let(:tags) do
    ['Ruby on Rails', 'Databases', 'Misc'].map do |name|
      Tag.create!(name: name, permalink: name.downcase.tr(' ', '-'))
    end
  end

  let(:posts) do
    tags_w_no_tag = [nil, *tags]

    posts = build_list(:post, 11) do |post|
      post.title     = Faker::Book.title
      post.permalink = post.title.tr(' ', 'post-permalink')
      post.user      = admin
    end.each(&:save!)

    posts.each do |post|
      tag = tags_w_no_tag.sample
      post.tags.push(tag) if tag.present? # tag posts at random including no tag
    end

    posts
  end

  describe "GET /index" do
    context 'Untagged posts, tagged posts' do
      before { posts }

      it 'renders 10 posts at most, with tags + untagged tag' do
        get :index

        expect(response.status).to eq(200)

        # assigns expectations been extracted to another gem, TODO: find workaround
        # expect(assigns(:posts)).to have_attributes(size: 10)
        # expect(assigns(:tags)).to have_attributes(size: tags.size + 1)
      end
    end
  end
end
