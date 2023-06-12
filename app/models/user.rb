class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :reviews, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_one_attached :profile_image
  
  validates :nickname, length: { minimum: 2, maximum: 20 }, uniqueness: true
  
  def get_profile_image
    (profile_image.attached?) ? profile_image : 'no_image.jpg'
  end
  
  def self.guest
    find_or_create_by!(nickname: 'guestuser' ,email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
  
  # ゲストユーザーかどうかを判定する
  def guest?
    nickname == 'guestuser' && email == 'guest@example.com'
  end
  
end
