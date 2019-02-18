class Label < ApplicationRecord
  has_many :labelings, dependent: :destroy
  has_many :task_labelings, through: :labelings, source: :task

  validates :name, presence: true

end
