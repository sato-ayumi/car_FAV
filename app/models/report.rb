class Report < ApplicationRecord

  belongs_to :user
  belongs_to :review
  has_many :notifications, as: :target, dependent: :destroy

  validates :description, presence: true, length: { maximum: 200 }

end
