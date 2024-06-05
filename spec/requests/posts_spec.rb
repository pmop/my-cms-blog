require 'rails_helper'

RSpec.describe PostsController, type: :controller do
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

  before { posts }

  describe 'GET /index' do
    context 'Untagged posts, tagged posts' do

      it 'renders 10 posts at most, with tags + untagged tag' do
        get :index

        expect(response.status).to eq(200)

        all_tags_w_untagged = [*Tag.all, virtual_untagged_tag]
        expect(assigns(:posts)).to have_attributes(size: 10)
        expect(assigns(:tags).count).to eq(all_tags_w_untagged.size)
        expect(assigns(:tags)).to include(*all_tags_w_untagged)
      end
    end
  end

  describe 'GET /posts/search' do
    context 'Search untagged post' do
      let(:expected_result) do
        Post.includes(:tags).where(tags: { id: nil })
      end

      it 'fetches the expected posts, responds with OK' do
        get(:search, params: { tag: 'untagged' })

        expect(response.status).to eq(200)

        expect(assigns(:posts)).to eq(expected_result)
        expect(assigns(:tag)).to eq(virtual_untagged_tag)
      end
    end

    context 'Search post tagged with ror tag' do
      let(:tag_permalink) { 'ruby-on-rails' }
      let(:expected_result) do
        Post.includes(:tags).where(tags: { permalink: tag_permalink })
      end

      it 'fetches the expected posts, responds with OK' do
        get(:search, params: { tag: tag_permalink })

        expect(response.status).to eq(200)

        # TODO: can be improved
        expect(assigns(:posts).map(&:id)).to eq(expected_result.map(&:id))
      end
    end

    context 'Search by inexistent tag' do
      let(:tag_permalink) { 'bogus' }

      it 'fetches the expected posts, responds with OK' do
        get(:search, params: { tag: tag_permalink })

        expect(response.status).to eq(200)

        expect(assigns(:posts)).to be_empty
      end
    end
  end

  describe "GET /posts/:permalink" do
    context 'fetching existing Post' do
      let(:permalink) { posts.first.permalink }

      it 'fetches the correct post, responds correctly' do
        get(:show, params: { id: permalink })

        expect(response.status).to eq(200)

        expect(assigns(:post)).to eq(posts.first)
      end
    end

    context 'fetching inexistent Post' do
      let(:permalink) { 'bogus' }

      it 'raises not found error, returns not found' do
        expect { get(:show, params: { id: permalink }) }.to \
          raise_error(::ActiveRecord::RecordNotFound)

        # expect(response.status).to eq(404) TODO: FIX
      end
    end
  end
end
