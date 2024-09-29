class ResourcesController < ApplicationController
  def create    
    selected_resources = params[:selected_resources] || []
    puts selected_resources
  end

  def destroy
    client = BigCommerceClient.new(session[:access_token], session[:store_hash])
    # client.delete_products
    client.delete_customers
    # client.delete_orders
  end
end
