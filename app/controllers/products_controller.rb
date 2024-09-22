class ProductsController < ApplicationController
  def index
    client = BigCommerceClient.new(session[:access_token], session[:store_hash])
    @products = client.get_products    
  end

  def create
    client = BigCommerceClient.new(session[:access_token], session[:store_hash])
    sample_data_generator = SampleDataGenerator.new
    sample_products = sample_data_generator.generate_sample_products    
    sample_products.each do |product_params|
      client.create_product(product_params)
    end
  end
end
