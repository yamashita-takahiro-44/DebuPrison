class MealsController < ApplicationController
  before_action :set_meal, only: [:show, :edit, :update, :destroy]

  def index
    @meals = current_user.meals
  end

  def new
    @meal = current_user.meals.new
  end

  def create
    @meal = current_user.meals.new(meal_params)
    if @meal.save
      redirect_to meals_path, notice: 'Meal was successfully added.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @meal.update(meal_params)
      redirect_to meals_path, notice: 'Meal was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @meal.destroy
    redirect_to meals_path, notice: 'Meal was successfully deleted.'
  end

  def search
    service = FatSecretApiService.new
    @foods = service.search_food(params[:query])

    render json: @foods
  end

  private

  def set_meal
    @meal = current_user.meals.find(params[:id])
  end

  def meal_params
    params.require(:meal).permit(:name, :calories, :date_time)
  end
end
