# frozen_string_literal: true

class HomeController < ApplicationController
  def index
    # TODO: optimize queries
    @posts = Post.with_rich_text_content.first(4)
    @tags = Tag.all
  end
end
