class Report < ApplicationRecord
  
  belongs_to :user
  belongs_to :review
  
  validates :description, presence: true, length: { maximum: 200 }
  
end
