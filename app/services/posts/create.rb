class Services::Posts::Create do
  def initialize(title:, content:, user:)
    title   = title
    content = content
    user    = user
  end

  def call
    create_post.tap do
    end
  end

  private

  attr_reader :title, :content, :user

  def create_post
    @create_post ||= Post.new.tap do |p|
      p.title = title
      p.content = content
      p.user = user
      p.permalink = generate_permalink
    end.save!
  end

  def associate_post_untagged_tag
    ::PostsTag.create!(post: create_post, tag: untagged_tag)
  end

  def generate_permalink
    title
      .downcase
      .gsub(/[^a-z]/, '')
      .gsub(/\s+/, '_') + SecureRandom.hex(4).to_s
  end

  def untagged_tag
    @untagged_tag ||= Tag.find_by!(permalink: 'untagged')
  end
end
