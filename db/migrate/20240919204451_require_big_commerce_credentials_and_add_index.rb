class RequireBigCommerceCredentialsAndAddIndex < ActiveRecord::Migration[7.1]
  def change
    change_column_null :big_commerce_credentials, :store_hash, false
    change_column_null :big_commerce_credentials, :store_owner, false
    change_column_null :big_commerce_credentials, :access_token, false

    add_index :big_commerce_credentials, :store_hash, unique: true
  end
end
