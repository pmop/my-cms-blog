class DashboardController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all
    @users = User.all
    @tags = Tag.all
  end
end
