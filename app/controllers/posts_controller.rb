# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]
  before_action :set_user, only: %i[create update]
  before_action :authenticate_user!, only: %i[new edit update destroy]
  include TagsHelper

  # GET /posts/search
  def search
    tag_permalink = sanitize_tag_permalink(params.permit(:tag)[:tag])

    @posts = Post.by_tag_permalink(tag_permalink).limit(posts_limit)
    @tag = virtual_tag_for(@posts[0], tag_permalink)
    @pages = pages_for(@posts)

    render :index
  end

  # GET /posts
  def index
    @tags = [*Tag.all, virtual_untagged_tag]
    @posts = Post.with_rich_text_content.first(posts_limit)
    @pages = pages(@posts)
  end

  # GET /posts/1
  def show
    @post = Post.includes(:user, :tags).with_rich_text_content.find_by!(permalink: params[:id])
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit; end

  # POST /posts
  def create
    @post = ::Services::Posts::Create.new(title: post_params[:title],
                                          content: post_params[:content],
                                          user: @user)
    @post.user = @user

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
    params = {
      title: post_params[:title],
      content: post_params[:content]
    }

    respond_to do |format|
      if @post.update(params)
        format.html do
          redirect_to post_path(@post.permalink),
                      notice: 'Post was successfully updated.'
        end
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /posts/1
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to :index, notice: 'Post was successfully destroyed.' }
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

  # Only allow a list of trusted parameters through.
  def post_params
    params.require(:post).permit(:title, :content)
  end

  def search_params
    params.permit(:permalink)
  end

  def posts_limit
    10
  end

  def pages_for(posts)
    (posts.count/posts_limit) + 1
  end

  def untagged_posts
    @posts = Post.untagged
    @tag = virtual_untagged_tag

    render :index
  end
end
