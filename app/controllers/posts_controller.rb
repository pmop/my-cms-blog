class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  before_action :set_tags, only: [:new]
  before_action :set_user, only: [:create, :update]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
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
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
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
