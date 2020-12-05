class Todo < ApplicationRecord
  validate :body, presence: true
end
