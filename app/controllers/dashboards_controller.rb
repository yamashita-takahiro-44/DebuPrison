class DashboardsController < ApplicationController
  before_action :authenticate_user!

  def show
    @meals = current_user.meals.order(date_time: :desc).limit(5)
    @exercises = current_user.exercises.order(date_time: :desc).limit(5)
    @goals = current_user.goals.order(start_date: :desc)
    @recent_posts = Post.order(created_at: :desc).limit(5)
  end
end
