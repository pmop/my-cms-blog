class Post < ApplicationRecord

  include ActionView::Helpers::TextHelper
  include ActionView::Helpers::SanitizeHelper

  scope :newest, -> { order('created_at DESC') }
  belongs_to :user
  has_rich_text :content

  has_and_belongs_to_many :tags
  has_one :comment_area, dependent: :destroy
  has_many :comments, through: :comment_area

  before_save do
    self.summary = truncate(strip_tags(self.content.to_s), length: 300)
  end
end
