module ApplicationHelper
  def basal_metabolic_rate(user)
    return 0 unless user.current_weight && user.height && user.age
    if user.gender == "Male"
      return ((13.397 * user.current_weight) + (4.799 * user.height) - (5.677 * user.age) + 88.362 ) * 1.5
    elsif user.gender == "Female"
      return ((9.247 * user.current_weight) + (3.098 * user.height) - (4.33 * user.age) + 447.593 ) * 1.5
    else
      return 0
    end
  end
end
