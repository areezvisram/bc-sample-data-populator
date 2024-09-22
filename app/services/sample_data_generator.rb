class SampleDataGenerator
  def generate_sample_products
    load_sample_products
  end

  def generate_sample_customers
    load_sample_customers
  end

  private
  def load_sample_products
    YAML.load_file(Rails.root.join('lib', 'sample_data', 'sample_products.yml'))['products']
  end

  def load_sample_customers
    YAML.load_file(Rails.root.join('lib', 'sample_data', 'sample_customers.yml'))['customers']
  end
end