class HomeController < ApplicationController
  def index
    # TODO optimize queries
    @posts = Post.all.newest
    @tags = Tag.all
  end

  def auth
  end
end
