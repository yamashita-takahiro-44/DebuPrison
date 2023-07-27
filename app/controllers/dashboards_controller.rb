class DashboardsController < ApplicationController
  before_action :authenticate_user!
  include ApplicationHelper

  def show
    @current_weight = current_user.current_weight
    @target_weight = current_user.goals.last&.target_weight # 一番最近の目標体重を取得
      
    @basal_metabolic_rate = basal_metabolic_rate(current_user)
    
    today_start = Time.now.beginning_of_day
    today_end = Time.now.end_of_day
    
    @total_calories_burned = current_user.exercises.where(date_time: today_start..today_end).sum(:calories_burned) + basal_metabolic_rate(current_user)
    @total_calories_eaten = current_user.meals
    .joins(:meal_details)
    .where(meal_date: today_start..today_end)
    .sum("meal_details.meal_calorie")

    # total_calories_eaten が total_calories_burned を超えた場合の処理
    if @total_calories_eaten > @total_calories_burned
      create_automatic_post
      flash[:alert] = "今日の摂取カロリーが消費カロリーを超えたため、掲示板に晒しました。"
    end
  end

  private

  def create_automatic_post
    # 今日の自動投稿のタイトルを生成
    auto_post_title = "#{current_user.name} - 今回の逮捕者"
  
    # 今日の自動投稿を確認
    today_automatic_post = current_user.posts.where(title: auto_post_title, created_at: Time.now.beginning_of_day..Time.now.end_of_day).exists?
  
    # 今日の自動投稿がすでに存在すればreturnして終了
    return if today_automatic_post
  
    # 今日のmealを取得
    today_meals = current_user.meals.where(meal_date: Time.now.beginning_of_day..Time.now.end_of_day)
  
    # 今日のmealに関連するmeal_detailsを取得
    today_meal_details = today_meals.flat_map(&:meal_details)
  
    # 今日の食事の内容を文字列で整形
    meals_string = today_meal_details.map do |detail|
      "#{detail.meal_title} (#{detail.meal_calorie} kcal)"
    end.join(", ")
  
    # 投稿の内容を整形
    post_content = "摂取カロリー: #{@total_calories_eaten}\n食べた食べ物: #{meals_string}"
  
    post_attributes = {
      title: auto_post_title,
      content: post_content,
      image: current_user.avatar
    }
  
    current_user.posts.create!(post_attributes)
  end
  
end
