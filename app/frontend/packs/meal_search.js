document.addEventListener('turbolinks:load', function() {
  const mealNameInput = document.getElementById('meal_name');
  const searchResultsContainer = document.getElementById('food-search-results');

  if (mealNameInput) {
    mealNameInput.addEventListener('keyup', function() {
      const query = mealNameInput.value;

      if (query.length > 2) {
        fetch(`/foods/search?query=${query}`, {
          headers: {
            'Accept': 'application/json'
          }
        })
        .then(response => response.json())
        .then(data => {
          let resultsHTML = '';
          data.forEach(food => {
            resultsHTML += `
              <div class="food-item" data-food-name="${food.name}" data-calories="${food.calories}">
                ${food.name} - ${food.calories} kcal
                <button class="select-food-btn">選択</button>
              </div>
            `;
          });
          searchResultsContainer.innerHTML = resultsHTML;
        });
      } else {
        searchResultsContainer.innerHTML = ''; // リクエスト文字数が短い場合、結果をクリア
      }
    });
  }

  // これを追加して食品の選択ボタンを処理します
  document.addEventListener('click', function(e) {
    if (e.target && e.target.classList.contains('select-food-btn')) {
      const foodItem = e.target.closest('.food-item');
      const foodName = foodItem.getAttribute('data-food-name');
      const calories = foodItem.getAttribute('data-calories');
      
      mealNameInput.value = foodName;
      document.getElementById('meal_calories').value = calories;
    }
  });
});
