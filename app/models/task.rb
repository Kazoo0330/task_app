class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true, length: { maximum: 500 }
end
