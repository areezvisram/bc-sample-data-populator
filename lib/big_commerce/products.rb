module BigCommerce
  class Products
    def initialize(client)
      @client = client
      @sample_data_generator = SampleDataGenerator.new
    end

    def populate_sample_products
      sample_products = @sample_data_generator.generate_sample_products    
      sample_products.each do |product_params|
        @client.create_product(product_params)
      end
    end

    def delete_sample_products
      @client.delete_products
    end
  end
end