namespace :posts do
  desc 'Seed fake Posts'
  task seed_dummy: :environment do

    admin = User.find_by_name('Admin')

    if admin.present? && Rails.env.development?

      Post.transaction do
        ::Posts::CreateService.new(
          title: Faker::Lorem.sentence(word_count: 3),
          user: admin,
          content: Faker::Lorem.sentence(word_count: 500),
        ).call
      end
    else
      p 'admin not present' if admin.nil?
      p 'environment not develop' if !Rails.env.development?
    end
  end
end
