class Post < ApplicationRecord
  belongs_to :user
  mount_uploader :image, ImageUploader
  
  validate :user_name_present

  private

  def user_name_present
    if user && user.name.blank?
      errors.add(:user, "name can't be blank")
    end
  end
end
