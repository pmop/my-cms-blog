json.extract! post, :id, :user_id, :tags_id, :comment_area_id, :content, :content_type, :created_at, :updated_at
json.url post_url(post, format: :json)
