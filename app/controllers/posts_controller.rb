class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]
  before_action :set_tags, only: [:new, :edit]
  before_action :set_user, only: [:create, :update]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  # GET /posts
  def index
    @posts = Post.all.includes(:tags).with_rich_text_content
  end

  # GET /posts/1
  def show
    @post = Post.find_by(permalink: params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  def create
    @post = Post.new(title: post_params[:title],
                     content:  post_params[:content],
                     permalink: generate_permalink(post_params[:title]) + SecureRandom.hex(4).to_s)

    set_tags(post_params[:tags])
    @post.user = @user

    @tags.each do |tag|
      @post.tags << tag
    end

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /posts/1
  def update
    hash = {
              title: post_params[:title],
              content: post_params[:content]
          }
    hash.merge({tags: set_tags(post_params[:tags])}) if not post_params[:tags].empty?

    respond_to do |format|
      if @post.update(hash)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_user
      @user = current_user
    end

    def generate_permalink(title)
      title
        .downcase
        .gsub(/[^a-z]/,'')
        .gsub(/\s+/, '_')
    end

    def find_or_create_tag(tag_name)
      permalink = generate_permalink(tag_name)
      t = Tag.find_by(permalink: permalink)
      unless t.present?
        t = Tag.create!(name: tag_name, permalink: permalink)
      end
      return t
    end

    def set_tags(tags=nil)
      if not tags.nil? # We transform from tag name array to tag instance array
        @tags = process_tags_from_input(post_params[:tags])
        if @tags.empty?
          @tags << find_or_create_tag("untagged")
        end

      else # We transform from tag instances array to tag names array
        unless @post.nil?
          @tags = @post.tags.map {|tag| tag.name }.join(',')
        else
          @tags = ["Untagged"]
        end
      end
    end

    # Tags currently are submited in a comma separated string array
    # so we need to transform it into an array of tag models
    def process_tags_from_input(tags)
      tags.split(',')
        .map { |tag| find_or_create_tag(tag.strip) }
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:title, :tags, :content)
    end
end
