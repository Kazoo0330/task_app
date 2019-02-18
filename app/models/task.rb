class Task < ApplicationRecord
  belongs_to :user
  has_many :labelings, dependent: :destroy
  has_many :labels, through: :labelings, source: :label


  enum status: { 未着手🦖:0, 着手中🐕💨:1, 完了✅:3 }
  enum priority: { あとでいいや🙈: 0, やりたい🙉: 1,  今すぐやらなきゃ🙊: 2 }

  validates :title, presence: true, length: { maximum: 140 }
  validates :content, presence: true, length: { maximum: 500 }
  validates :status, presence: true

  scope :search_with_title, -> (title) {
    where("title LIKE ?", "%#{ title }%")
  }

  scope :search_with_content, -> (content) {
    where("content LIKE ?", "%#{ content }%")
  }

  scope :search_with_status, -> (status) {
    where(status: status)
  }

  scope :search_with_label, -> (label_id) {
    task_ids = Labeling.where(label_id: label_id).pluck(:task_id)
    where(id: task_ids)
  }

end
