# frozen_string_literal: true

json.extract! user, :id, :emal, :name, :password_digest, :posts_id, :created_at, :updated_at
json.url user_url(user, format: :json)
