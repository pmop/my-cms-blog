class HomeController < ApplicationController
  def index
    # TODO optimize queries
    @posts = Post.all.newest.with_rich_text_content
    @tags = Tag.all
  end
end
