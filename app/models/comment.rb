class Comment < ApplicationRecord
  
  belongs_to :user
  belongs_to :review
  # 返信対象となるコメント optional: trueで外部キーのnilを許可
  belongs_to :parent, class_name: "Comment", optional: true
  # 返信されたコメント
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  
  validates :comment, presence: true, length: { maximum: 200 }
  
end
