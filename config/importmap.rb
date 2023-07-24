# Pin npm packages by running ./bin/importmap
# config/importmap.rb

Rails.application.config.importmap.draw do
  pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
  pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
  pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
  pin "meal_search", to: "packs/meal_search.js"

  pin "application", to: "application.js", preload: true
  pin_all_from "app/javascript/controllers", under: "controllers"
end
