class Task < ApplicationRecord
  enum status: { 未着手:0, 着手中:1, 完了✅:3 }

  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :status, presence: true

  # def self.search(search)
  #   if search
  #     Task.where(['title LIKE ?', "%#{ search }%"])
  #     Task.where(['content LIKE ?', "%#{ search }%"])
  #   else
  #     Task.all
  #   end
  # end

  scope :search_with_title, -> (title) {
    where("title LIKE ?", "%#{ title }%")
  }

  scope :search_with_content, -> (content) {
    where("content LIKE ?", "%#{ content }%")
  }

  scope :search_with_status, -> (status) {
    where(status: status)
  }
end
