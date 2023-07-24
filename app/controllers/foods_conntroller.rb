class FoodsController < ApplicationController
  def search
    service = FatSecretApiService.new
    @foods = service.search_food(params[:query])

    render json: @foods
  end
end
