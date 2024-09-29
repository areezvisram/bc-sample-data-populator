class OrdersController < ApplicationController
  def index
    client = BigCommerceClient.new(session[:access_token], session[:store_hash])
    @orders = client.get_orders
  end

  def create
    client = BigCommerceClient.new(session[:access_token], session[:store_hash])
    client.create_orders
  end
end
