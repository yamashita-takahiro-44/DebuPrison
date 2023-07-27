class Meal < ApplicationRecord
  enum meal_period: { breakfast: 0, lunch: 1, dinner: 2, nosh: 3 }
  enum meal_type: { self_catering: 0, eating_out: 1, to_go: 2, convenience_store: 3 }

  belongs_to :user
  has_many :meal_details, dependent: :destroy
  has_many_attached :meal_images do |attachable|
    attachable.variant :thumb, resize_to_limit: [400, 400]
  end

  validates :meal_images, attachment: { purge: true, content_type: %r{\Aimage/(png|jpeg|jpg)\Z}, maximum: 5_242_880 }

  mount_uploaders :meal_images, MealImageUploader

  validate :user_name_present

  private

  def user_name_present
    if user && user.name.blank?
      errors.add(:user, "name can't be blank")
    end
  end

end
