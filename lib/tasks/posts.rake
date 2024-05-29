namespace :posts do
  desc 'Seed fake Posts'
  task seed_dummy: :environment do

    admin = User.find_by_name('Admin')

    if admin.present? && Rails.env.development?
      untagged = Tag.find_by_permalink('untagged')

      title = Faker::Lorem.sentence(word_count: 3)
      params = {
        title: title,
        user: admin,
        content: Faker::Lorem.sentence(word_count: 500),
        permalink: title.downcase.sub(' ', '-'),
      }
      Post.transaction do
        Post.create!(params).tap do |post|
          p "Seeded #{post.title} posts.id #{post.id}"
        end

        PostsTag.create!(post: post, tag: untagged)
      end
    else
      p 'admin not present' if admin.nil?
      p 'environment not develop' if !Rails.env.development?
    end
  end
end
