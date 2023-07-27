class MealForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :meal_date, :datetime
  attribute :meal_period, :integer
  attribute :meal_type, :integer
  attribute :meal_memo, :string
  attribute :user_id
  attribute :meal_title_first, :string
  attribute :meal_weight_first, :integer
  attribute :meal_calorie_first, :integer
  attribute :meal_title_second, :string
  attribute :meal_weight_second, :integer
  attribute :meal_calorie_second, :integer
  attribute :meal_title_third, :string
  attribute :meal_weight_third, :integer
  attribute :meal_calorie_third, :integer
  attribute :meal_images

  validates :meal_date, presence: true
  validates :meal_period, presence: true
  validates :meal_type, presence: true
  validates :meal_title_first, presence: true, length: { maximum: 20 }
  validates :meal_weight_first, presence: true
  validates :meal_calorie_first, presence: true
  validates :meal_memo, length: { maximum: 100 }

  delegate :persisted?, to: :meal

  def initialize(attributes = nil, meal: Meal.new)
    @meal = meal
    attributes ||= default_attributes
    super(attributes)
  end

  def save
    return false if invalid?

    if meal.meal_details.size > 3
      (3...meal.meal_details.size).each do
        meal.meal_details.last.delete
      end
    end

    ActiveRecord::Base.transaction do
      if meal.meal_images.blank?
        meal.update!(meal_date: meal_date, meal_period: meal_period, meal_type: meal_type, meal_memo: meal_memo, user_id: user_id)
      else
        meal.update!(meal_date: meal_date, meal_period: meal_period, meal_type: meal_type, meal_memo: meal_memo, user_id: user_id, meal_images: meal_images)
      end
      
      update_or_create_detail(meal_title_first, meal_weight_first, meal_calorie_first, 0)
      update_or_create_detail(meal_title_second, meal_weight_second, meal_calorie_second, 1)
      update_or_create_detail(meal_title_third, meal_weight_third, meal_calorie_third, 2)
    end

    meal
  rescue ActiveRecord::RecordInvalid
    errors.merge!(meal.errors)
    false
  end

  def to_model
    meal
  end

  attr_reader :meal

  private

  def update_or_create_detail(title, weight, calorie, index)
    detail = meal.meal_details[index]
    
    if title.blank?
      detail&.delete
      return
    end

    if detail
      detail.update!(meal_title: title, meal_weight: weight, meal_calorie: calorie)
    else
      meal.meal_details.create!(meal_title: title, meal_weight: weight, meal_calorie: calorie)
    end
  end

  def default_attributes
    {
      user_id: meal.user_id,
      meal_date: meal.meal_date,
      meal_period: meal.meal_period_before_type_cast,
      meal_type: meal.meal_period_before_type_cast,
      meal_memo: meal.meal_memo,
      meal_images: meal.meal_images,
      meal_title_first: meal_title_or_empty(0),
      meal_weight_first: meal_weight_or_empty(0),
      meal_calorie_first: meal_calorie_or_empty(0),
      meal_title_second: meal_title_or_empty(1),
      meal_weight_second: meal_weight_or_empty(1),
      meal_calorie_second: meal_calorie_or_empty(1),
      meal_title_third: meal_title_or_empty(2),
      meal_weight_third: meal_weight_or_empty(2),
      meal_calorie_third: meal_calorie_or_empty(2)
    }
  end

  def meal_title_or_empty(index)
    meal.meal_details[index]&.meal_title || ''
  end

  def meal_weight_or_empty(index)
    meal.meal_details[index]&.meal_weight || ''
  end

  def meal_calorie_or_empty(index)
    meal.meal_details[index]&.meal_calorie || ''
  end
end
