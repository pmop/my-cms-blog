# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit show update destroy]
  before_action :set_post, except: [:index]
  before_action :authenticate_user!

  # GET /comments
  # GET /comments.json
  def index
    @comments = Comment.all
  end

  # Gets all comments. From post nested resource
  def show
    # GET /posts/1/comments/
    return unless @post.present?

    @comments = @post.comments.includes(:user).with_rich_text_content
  end

  # New comment. From post nested resource
  def new
    # GET /posts/1/comments/new
    return unless @post.present?

    @comment = Comment.new
    @comment.post = @post
  end

  # GET /comments/1/edit
  # Edit comment. From post nested resource
  def edit; end

  # POST /comments
  # POST /comments.json
  def create
    @comment = Comment.new(comment_params)
    @comment.post = @post
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        @post.comments << @comment
        format.html { redirect_to post_path(@post.permalink), notice: 'Comment was successfully created.' }
        format.json { render :show, status: :created, location: @comment }
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { redirect_to post_path(@post.permalink), notice: 'Comment was successfully updated.' }
        format.json { render :show, status: :ok, location: @comment }
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path(@post.permalink), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  # Only allow a list of trusted parameters through.
  def comment_params
    params.require(:comment).permit(:content)
  end
end
