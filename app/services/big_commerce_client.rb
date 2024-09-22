# require 'bigcommerce'
require 'httparty'

class BigCommerceClient
  def initialize(access_token, store_hash)
    @store_hash = store_hash
    @access_token = access_token
  end

  def create_product(params)
    url = "https://api.bigcommerce.com/stores/#{@store_hash}/v3/catalog/products"
    headers = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'X-Auth-Token' => @access_token
    }

    response = HTTParty.post(url, headers: headers, body: params.to_json)
    if response.success?
      puts "Product created successfully."
    else
      puts response
    end
  end

  def create_customers(params)
    url = "https://api.bigcommerce.com/stores/#{@store_hash}/v3/customers"
    headers = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'X-Auth-Token' => @access_token
    }

    response = HTTParty.post(url, headers: headers, body: params.to_json)
    if response.success?
      puts "Customers created successfully."
    else
      puts response
    end
  end

  def get_products
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