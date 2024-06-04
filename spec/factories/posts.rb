FactoryBot.define do
  factory :post, class: 'Post' do
    title     { 'Post Title' }
    permalink { 'post-permalink' }
    content   { Faker::Lorem.sentence(word_count: 300) }
  end
end
