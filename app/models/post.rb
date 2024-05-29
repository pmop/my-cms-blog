# frozen_string_literal: true

class Post < ApplicationRecord
  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper

  belongs_to :user
  has_rich_text :content

  has_many :comments

  before_save do
    self.summary = truncate(strip_tags(content.to_s), length: 300)
  end
end
