class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :goals
  has_many :meals
  has_many :exercises
  has_many :posts
  has_many :user_badges
  has_many :badges, through: :user_badges

  mount_uploader :avatar, AvatarUploader

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      # 他の必要な初期設定を追加
    end
  end
end
