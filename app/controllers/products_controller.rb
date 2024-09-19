class ProductsController < ApplicationController
  def index
    puts "I am calling index"
    debugger
    client = BigCommerceClient.new(session[:access_token], session[:store_hash])
    @products = client.get_products
    # puts @products
  end

  def create
    client = BigCommerceClient.new(session[:access_token], session[:store_hash])
    product_params = {
      name: 'Sample Product',
      type: 'physical',
      price: 19.99,
      weight: 1.2,
      categories: [1]
    }
    client.create_product(product_params)
    redirect_to products_path
  end
end
