class ProductsController < ApplicationController
  def index
    client = BigCommerceClient.new(session[:access_token], session[:store_hash])
    @products = client.get_products
    # puts @products
  end

  def create
    sample_data_generator = SampleDataGenerator.new(nil)
    sample_products = sample_data_generator.generate_sample_products
    debugger
    # sample_products.each do |product_params|
    #   puts product_params
    # end
    # client = BigCommerceClient.new(session[:access_token], session[:store_hash])
    # client.create_product(product_payload)
    # redirect_to products_path
  end
end
