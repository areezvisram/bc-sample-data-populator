class SampleDataGenerator
  def initialize(bigcommerce_client)
    @bigcommerce_client = bigcommerce_client
  end

  def generate_sample_products
    load_sample_products
  end

  private
  def load_sample_products
    YAML.load_file(Rails.root.join('lib', 'sample_data', 'sample_products.yml'))['products']
  end
end