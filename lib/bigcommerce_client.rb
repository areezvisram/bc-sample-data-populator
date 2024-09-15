class BigCommerceClient
  def initialize(access_token, store_hash)
    @client = Bigcommerce::Api.new({
      store_hash: store_hash,
      client_id: Rails.application.credentials.bigcommerce[:client_id],
      access_token: access_token,
  })
  end

  def create_product(params)
    @client.create_product(params)
  end

  def get_products
    @client.products
  end
end