SitemapGenerator::Sitemap.default_host = "https://debuprison.com"

SitemapGenerator::Sitemap.create do
  # 静的ページ
  add root_path
  add privacy_path
  add service_path
  add profile_path

  # リソースに基づくページ
  User.find_each do |user|
    add profile_show_path(user)
  end

  Meal.find_each do |meal|
    add meal_path(meal)
  end

  Exercise.find_each do |exercise|
    add exercise_path(exercise)
  end

  Badge.find_each do |badge|
    add badge_path(badge)
  end

  Goal.find_each do |goal|
    add goal_path(goal)
  end

  Post.find_each do |post|
    add post_path(post)
  end

  # その他のルート
  add dashboard_path
end
