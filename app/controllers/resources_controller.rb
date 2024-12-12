class ResourcesController < ApplicationController
  def create
    client = BigCommerceClient.new(session[:access_token], session[:store_hash])
    selected_resources = params[:selected_resources] || []    
    if selected_resources.include?("products")
      BigCommerce::Products.new(client).populate_sample_products
    end

    if selected_resources.include?("customers")
      BigCommerce::Customers.new(client).populate_sample_customers
    end

    if selected_resources.include?("orders")
      BigCommerce::Orders.new(client).populate_sample_orders
    end
  end

  def destroy
    client = BigCommerceClient.new(session[:access_token], session[:store_hash])
    BigCommerce::Products.new(client).delete_sample_products
    BigCommerce::Customers.new(client).delete_sample_customers
    BigCommerce::Orders.new(client).delete_sample_orders
  end
end
