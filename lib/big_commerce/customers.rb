module BigCommerce
  class Customers
    def initialize(client)
      @client = client
      @sample_data_generator = SampleDataGenerator.new
    end

    def populate_sample_customers
      sample_customers = @sample_data_generator.generate_sample_customers    
      @client.create_customers(sample_customers)
    end

    def delete_sample_customers
      @client.delete_customers
    end
  end
end