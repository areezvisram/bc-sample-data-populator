class SessionsController < ApplicationController
  def new
    # If the request is not already at the BigCommerce auth path, redirect
    unless request.path == "/auth/bigcommerce"
      redirect_to "/auth/bigcommerce"
    end
  end
  def create
    auth = request.env["omniauth.auth"]
    Rails.logger.info "Auth hash: #{auth.inspect}"
    
    access_token = auth['credentials']['token'].token
    store_hash = auth['extra']['context'].split('/').last
    store_owner = auth['info']['email']

    credential = BigCommerceCredential.find_or_initialize_by(store_hash: store_hash)
    credential.update(access_token: access_token, store_owner: store_owner)

    session[:bigcommerce_credential_id] = credential.id

    redirect_to products_path
  end
end
