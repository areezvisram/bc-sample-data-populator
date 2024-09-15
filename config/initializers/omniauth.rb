Rails.application.config.middleware.use OmniAuth::Builder do
  provider :bigcommerce,
    Rails.application.credentials.bigcommerce[:client_id],
    Rails.application.credentials.bigcommerce[:client_secret],
    scope: 'store_v2_default',
    client_options: {
      site: 'https://login.bigcommerce.com',
      authorize_url: '/oauth2/authorize',
      token_url: '/oauth2/token'
    }
end