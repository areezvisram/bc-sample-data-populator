# require 'bigcommerce'
require 'httparty'

class BigCommerceClient
  def initialize(access_token, store_hash)
    # debugger
    @store_hash = store_hash
    @access_token = access_token
  #   @client = Bigcommerce.new({
  #     store_hash: store_hash,
  #     client_id: Rails.application.credentials.bigcommerce[:client_id],
  #     access_token: access_token,
  # })
    # @connection = Bigcommerce::Connection.build(
    #   Bigcommerce::Config.new(
    #     store_hash: store_hash,
    #     client_id: Rails.application.credentials.bigcommerce[:client_id],
    #     access_token: access_token
    #   )
    # )
    # Bigcommerce.configure do |config|
    #   config.store_hash = store_hash
    #   config.client_id = Rails.application.credentials.bigcommerce[:client_id]
    #   config.access_token = access_token
    # end

    # puts Bigcommerce::System.time

  end

  def create_product(params)
    Bigcommerce::Product.create(params, @connection)
  end

  def get_products
    puts "I am calling get_products"
    # debugger
    # @products = Bigcommerce::Product.all(connection: @connection)
    url = "https://api.bigcommerce.com/stores/#{@store_hash}/v3/catalog/products"
    headers = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'X-Auth-Token' => @access_token
    }
    response = HTTParty.get(url, headers: headers)

    if response.success? && response['data']
      response['data'].map { |product| product['name'] }
    else
      []
    end
  end
end