class FoodsController < ApplicationController
  def search
    puts params[:query] # この行を追加
    service = FatSecretApiService.new
    @foods = service.search_food(params[:query])

    render json: @foods
  end
end
