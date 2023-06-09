class Tag < ApplicationRecord
  
  has_many :tag_maps, dependent: :destroy, foreign_key: "tag_id"
  has_many :reviews, through: :tag_maps
  
  def self.search(search)
    if search != "#"
      tag = Tag.where(tag_name:search)
      tag[0].reviews
    else
      Review.all
    end
  end
end
