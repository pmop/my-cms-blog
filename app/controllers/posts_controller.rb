# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]
  before_action :set_user, only: %i[create update]
  before_action :authenticate_user!, only: %i[new edit update destroy]

  def search; end

  # GET /posts
  def index
    @posts = Post.all.with_rich_text_content
  end

  # GET /posts/1
  def show
    @post = Post.includes(:user).with_rich_text_content.find_by(permalink: params[:id])
    @comment = Comment.new
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
      format.html { redirect_to dashboard_url, notice: 'Post was successfully destroyed.' }
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
end
