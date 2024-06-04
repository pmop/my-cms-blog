# frozen_string_literal: true

class TagsController < ApplicationController
  # GET /tags
  def show; end

  def index
    @tags = Tag.all
  end
end
