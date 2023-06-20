class Comment < ApplicationRecord

  after_create :create_notification_for_review_comment
  after_create :create_notification_for_comment_reply

  belongs_to :user
  belongs_to :review
  # 返信対象となるコメント optional: trueで外部キーのnilを許可
  belongs_to :parent, class_name: "Comment", optional: true
  # 返信されたコメント
  has_many :replies, class_name: "Comment", foreign_key: :parent_id, dependent: :destroy
  has_many :notifications, as: :target, dependent: :destroy

  validates :comment, presence: true, length: { maximum: 200 }

  # 投稿に対してコメントされたユーザーへの通知の生成
  def create_notification_for_review_comment
    Notification.create(user: review.user, target: self, action: "comment") unless parent.present?
  end

  # コメントに対して返信されたユーザーへの通知の生成
  def create_notification_for_comment_reply
    Notification.create(user: parent.user, target: self, action: "comment") if parent.present?
  end

end
