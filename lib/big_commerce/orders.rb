module BigCommerce
  class Orders
    def initialize(client)
      @client = client
    end

    def populate_sample_orders
      @client.create_orders
    end

    def delete_sample_orders
      @client.delete_orders
    end
  end
end