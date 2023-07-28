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
  attribute :meal_image

  validates :meal_date, presence: true
  validates :meal_period, presence: true
  validates :meal_type, presence: true
  validates :meal_title_first, presence: true, length: { maximum: 20 }
  validates :meal_weight_first, presence: true
  validates :meal_calorie_first, presence: true
  validates :meal_memo, length: { maximum: 100 }

  delegate :persisted?, to: :meal

  def initialize(attributes = {})
    @meal = attributes[:meal] || Meal.new(user_id: attributes[:user_id])
    
    Rails.logger.debug "渡された画像: #{attributes[:meal_image].inspect}"
    Rails.logger.debug "既存のMealの画像: #{@meal.meal_image.inspect}"
  
    # 画像が渡されていない場合、既存のmealの画像をデフォルトとして使用します。
    attributes[:meal_image] ||= @meal.meal_image if @meal.meal_image.present?
  
    super(attributes)
  end
  
  

  def save
    return false if invalid?

    ActiveRecord::Base.transaction do
      meal.update!(meal_date: meal_date, 
                   meal_period: meal_period, 
                   meal_type: meal_type, 
                   meal_memo: meal_memo, 
                   user_id: user_id, 
                   meal_image: meal_image,
                   meal_title_first: meal_title_first, 
                   meal_weight_first: meal_weight_first,
                   meal_calorie_first: meal_calorie_first,
                   meal_title_second: meal_title_second, 
                   meal_weight_second: meal_weight_second, 
                   meal_calorie_second: meal_calorie_second, 
                   meal_title_third: meal_title_third, 
                   meal_weight_third: meal_weight_third, 
                   meal_calorie_third: meal_calorie_third)

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
      meal_type: meal.meal_type_before_type_cast,
      meal_memo: meal.meal_memo,
      meal_image: meal.meal_image,
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
