class Review < ApplicationRecord

  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :tag_maps, dependent: :destroy
  has_many :tags, through: :tag_maps

  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 150 }
  validates :maker, presence: true
  validates :review_image, presence: true

  has_one_attached :review_image

  def save_tag(sent_tags)
    # 保存した投稿に紐付いているタグが存在する場合、タグの名前を配列として全て取得。
    current_tags = self.tags.pluck(:tag_name) unless self.tags.nil?
    # 存在するタグから送信されてきたタグを除いたもの（既にあるタグ）
    old_tags = current_tags - sent_tags
    # 送信されてきたタグから、存在するタグを除いたもの（新しいタグ）
    new_tags = sent_tags - current_tags

    # 既にあるタグの削除
    old_tags.each do |old|
      self.tags.delete Tag.find_by(tag_name:old)
    end

    # 新しいタグの保存（find_or_create_byで条件を指定し１件もなければ作成）
    new_tags.each do |new|
      review_tag = Tag.find_or_create_by(tag_name:new)
      # 配列に保存
      self.tags << review_tag
    end
  end

  # メーカー （０= トヨタ  / １= 日産 / ２= ホンダ / ３= マツダ / ４= スズキ / 5 = スバル / 6 = その他 / 7 = 外国産  ）
  enum maker: { toyota: 0, nissan: 1, honda: 2, mazda: 3, suzuki: 4, subaru: 5, others: 6, foreign: 7 }
  
  # ステータス　（0 = 公開 / 1 = 非公開）
  enum status: { published: 0, draft: 1 }
  
  # makerカラムの日本語化
  def self.maker_options
    # .mapで37行目をkey, _vlueで受け取り、I18n.tで該当の日本語を返す
    makers.map { |key, _value| [I18n.t("enums.review.maker.#{key}"), key] }
  end
  
end
