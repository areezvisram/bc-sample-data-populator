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

  def create_orders
    url = "https://api.bigcommerce.com/stores/#{@store_hash}/v2/orders"
    headers = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'X-Auth-Token' => @access_token
    }

    orders = generate_sample_orders
    orders.each do |order|
      response = HTTParty.post(url, headers: headers, body: order.to_json)
      if response.success?
        puts "Order created successfully."
      else
        puts response
      end
    end

  end

  def get_products
    products = []
    current_page = 1
    total_pages = nil
  
    loop do
      url = "https://api.bigcommerce.com/stores/#{@store_hash}/v3/catalog/products"
      headers = {
        'Accept' => 'application/json',
        'Content-Type' => 'application/json',
        'X-Auth-Token' => @access_token
      }
      response = HTTParty.get(url, headers: headers, query: { include: 'options', page: current_page, limit: 10 })
  
      if response.success? && response['data']
        products.concat(response['data'])
        total_pages ||= response['meta']['pagination']['total_pages']
        current_page += 1
      else
        break
      end
  
      break if current_page > total_pages
    end
  
    products
  end
  

  def get_customers
    url = "https://api.bigcommerce.com/stores/#{@store_hash}/v3/customers"
    headers = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'X-Auth-Token' => @access_token
    }
    response = HTTParty.get(url, headers: headers)

    if response.success? && response['data']
      response['data']
    else
      []
    end
  end

  def get_orders
    url = "https://api.bigcommerce.com/stores/#{@store_hash}/v2/orders"
    headers = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'X-Auth-Token' => @access_token
    }
    response = HTTParty.get(url, headers: headers)

    if response.success? && response['data']
      response['data']
    else
      []
    end
  end

  def delete_products
    product_ids = get_products.map { |product| product['id'] }.join(',')
    url = "https://api.bigcommerce.com/stores/#{@store_hash}/v3/catalog/products"
    headers = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'X-Auth-Token' => @access_token
    }
    response = HTTParty.delete(url, headers: headers, query: { 'id:in' => product_ids })

    if response.success?
      puts response
      puts "Products deleted successfully."
    else
      puts response
    end
  end

  def delete_customers
    customer_ids = get_customers.map { |customer| customer['id'] }.join(',')
    url = "https://api.bigcommerce.com/stores/#{@store_hash}/v3/customers"
    headers = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'X-Auth-Token' => @access_token
    }
    response = HTTParty.delete(url, headers: headers, query: { 'id:in' => customer_ids })

    if response.success?
      puts "Customers deleted successfully."
    else
      puts response
    end
  end

  def delete_orders
    url = "https://api.bigcommerce.com/stores/#{@store_hash}/v2/orders"
    headers = {
      'Accept' => 'application/json',
      'Content-Type' => 'application/json',
      'X-Auth-Token' => @access_token
    }
    response = HTTParty.delete(url, headers: headers)

    if response.success?
      puts "Orders deleted successfully."
    else
      puts response
    end
  end

  private
  def generate_sample_orders    
    products = get_products
    customers = get_customers    
    orders = []

    7.times do |i|
      order_customer = customers.sample      
      order_products = products.sample(rand(1..5))
      sample_address = generate_sample_address
      
      order = {
        status_id: rand(0..14),
        customer_id: order_customer['id'],
        billing_address: {
          first_name: order_customer['first_name'],
          last_name: order_customer['last_name'],
          street_1: sample_address[:street_1],
          city: sample_address[:city],
          state: sample_address[:state],
          zip: sample_address[:zip],
          country: 'United States',
          email: order_customer['email'],
          phone: order_customer['phone'],
        },
        products: order_products.map { |product| { product_id: product['id'], quantity: rand(1..10), product_options: select_product_options(product) } },
        shipping_addresses: [
          {
            first_name: order_customer['first_name'],
            last_name: order_customer['last_name'],
            street_1: sample_address[:street_1],
            city: sample_address[:city],
            state: sample_address[:state],
            zip: sample_address[:zip],
            country: 'United States',
          }
        ],
        shipping_cost_inc_tax: rand(5..50).round(2),        
        order_is_digital: [true, false].sample,
      }
      orders << order
    end
    orders
  end

  def select_product_options(product)
    product['options'].map do |option|
      {
        id: option['id'],
        value: option['option_values'].sample['id']
      }
    end
  end

  def generate_sample_address
    Faker::Config.locale = 'en-US'
    {
      street_1: Faker::Address.street_address,
      city: Faker::Address.city,
      state: Faker::Address.state,
      zip: Faker::Address.zip,
      country: 'United States',
    }
  end
end