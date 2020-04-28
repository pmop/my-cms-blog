class HomeController < ApplicationController
  def index
    # TODO optimize queries
    @posts = Post.all
  end

  def auth
  end
end
