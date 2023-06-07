class Review < ApplicationRecord
  
  belongs_to :user
  
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 150 }
  validates :maker, presence: true
  
  has_one_attached :review_image
  
  # メーカー （０= トヨタ  / １= 日産 / ２= ホンダ / ３= マツダ / ４= スズキ / 5 = スバル / 6 = その他 / 7 = 外国産  ）
  enum maker: {
      toyota: 0,
      nissan: 1,
      honda: 2,
      mazda: 3,
      suzuki: 4,
      subaru: 5,
      others: 6,
      foreign: 7
  }
  
end
