import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

import MealDetailFormController from "./meal_detail_form_controller"
application.register("meal-detail-form", MealDetailFormController)
