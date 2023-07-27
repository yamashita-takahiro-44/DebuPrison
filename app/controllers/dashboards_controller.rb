class DashboardsController < ApplicationController
  before_action :authenticate_user!
  include ApplicationHelper

  def show
    @current_weight = current_user.current_weight
    @target_weight = current_user.goals.last&.target_weight # 一番最近の目標体重を取得
      
    @basal_metabolic_rate = basal_metabolic_rate(current_user)
    
    today_start = Time.now.beginning_of_day
    today_end = Time.now.end_of_day
    
    @total_calories_burned = current_user.exercises.where(date_time: today_start..today_end).sum(:calories_burned)
    @total_calories_eaten = current_user.meals
    .joins(:meal_details)
    .where(meal_date: today_start..today_end)
    .sum("meal_details.meal_calorie")

  end
end

