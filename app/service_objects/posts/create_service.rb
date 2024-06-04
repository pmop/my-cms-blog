module Posts
  class CreateService
    def initialize(title:, content:, user:)
      @title   = title
      @content = content
      @user    = user

      validate!
    end

    def call
      build_post.tap(&:save!)
    end

    private

    attr_reader :title, :content, :user

    def validate!
      instance_variables.each do |var|
        raise ::Errors::InvalidParamError.new(var.to_s) if instance_variable_get(var).nil?
      end
    end

    def build_post
      Post.new.tap do |p|
        p.title = title
        p.content = content
        p.user = user
        p.permalink = generate_permalink
      end
    end

    def generate_permalink
      "#{title.downcase.tr('[A-z0-9]', '').tr('\s+', '-')}-#{SecureRandom.hex(4).to_s}"
    end
  end
end
