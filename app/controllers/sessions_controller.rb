class SessionsController < ApplicationController
  def new
    # # If the request is not already at the BigCommerce auth path, redirect
    unless request.path == "/auth/bigcommerce"
      redirect_to "/auth/bigcommerce"
    end
  end
  def create
    auth = request.env["omniauth.auth"]
    Rails.logger.info "Auth hash: #{auth.inspect}" 
    
    session[:access_token] = auth['credentials']['token']
    session[:store_hash] = auth['extra']['context'].split('/').last

    redirect_to root_path
  end
end
