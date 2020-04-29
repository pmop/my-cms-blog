class HomeController < ApplicationController
  def index
    # TODO optimize queries
    @posts = Post.all.with_rich_text_content.newest
    @tags = Tag.all
  end
end
