class TagsController < ApplicationController
  before_action :set_tag, only: %i[edit update destroy]
  before_action :authenticate_user!, only: %i[edit update destroy]

  def posts
    @tag = Tag.find_by(permalink: search_params)
    @posts = @tag.posts.newest
    respond_to do |format|
      unless (@posts.nil? || @tag.nil?)
        format.html { render :index,
                      notice: "Posts tagged as #{ search_params }"}
      else
        format.html { render :not_found }
      end
    end
  end

  # GET /tags
  def show
  end

  def index
    @tags = Tag.all
  end

  # GET /tags/1/edit
  def edit
  end

  # PATCH/PUT /tags/1
  def update
    respond_to do |format|
      if @tag.update(tag_params)
        format.html { redirect_to @tag, notice: 'Tag was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
    respond_to do |format|
      format.html { redirect_to tags_url,
                    notice: 'Tag was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      # set tag by id or permalink
      if params[:id].is_a? Integer
        @tag = Tag.find(params[:id])
      else
        @tag = Tag.find_by(permalink: params[:id])
        raise ActiveRecord::RecordNotFound if @tag.nil?
      end
    end

    def tag_params
      params.require(:tag).permit(:name, :posts_id)
    end

    def search_params
      params.require(:tag)
    end
end
