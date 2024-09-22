class CustomersController < ApplicationController
  def create
    client = BigCommerceClient.new(session[:access_token], session[:store_hash])
    sample_data_generator = SampleDataGenerator.new
    sample_customers = sample_data_generator.generate_sample_customers
    client.create_customers(sample_customers)
  end
end
