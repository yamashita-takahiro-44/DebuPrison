class FatSecretApiService
  BASE_URL = "https://platform.fatsecret.com/rest/server.api"

  def initialize(api_key = ENV['FATSECRET_API_KEY'], shared_secret = ENV['FATSECRET_SHARED_SECRET'])
    @api_key = api_key
    @shared_secret = shared_secret
  end
  def search_food(query)
    params = {
      method: 'foods.search',
      format: 'json',
      search_expression: query,
      oauth_consumer_key: @api_key
      # 他に必要なパラメーターを追加
    }
  
    response = HTTParty.get(BASE_URL, query: params)
  
    # 必要に応じてレスポンスを処理
    if response["foods"] && response["foods"]["food"]
      return [response["foods"]["food"]].flatten
    else
      return []
    end
  end
  
end
