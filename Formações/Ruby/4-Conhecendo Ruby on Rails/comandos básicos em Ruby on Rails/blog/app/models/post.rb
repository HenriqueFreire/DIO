class Post < ApplicationRecord
  validate: :title, :description, :text presence: true
end
