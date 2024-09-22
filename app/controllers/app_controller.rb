require 'jwt'
class AppController < ApplicationController
  def index
  end

  def load
    signed_payload_jwt = params[:signed_payload_jwt]
    decoded_payload = decode_jwt(signed_payload_jwt)

    store_hash = decoded_payload['sub'].split('/').last
    owner_email = decoded_payload['owner']['email']    
    
    credential = BigCommerceCredential.find_by(store_hash: store_hash)

    if credential
      # Could take out this check to allow all users on the store to use the app
      if credential.store_owner == owner_email        
        session[:access_token] = credential.access_token
        session[:store_hash] = credential.store_hash      

        redirect_to root_path, notice: 'Successfully loaded the app.'
      else
        redirect_to root_path, alert: 'Unauthorized User.'
      end
    else
      redirect_to root_path, alert: 'Credentials not found for the store.'
    end
  end

  private

  def decode_jwt(signed_payload_jwt)
    secret = Rails.application.credentials.bigcommerce[:client_secret]
    JWT.decode(signed_payload_jwt, secret, true, { algorithm: 'HS256' }).first
  rescue JWT::DecodeError => e
    Rails.logger.error "JWT Decode Error: #{e.message}"
    nil
  end
end
