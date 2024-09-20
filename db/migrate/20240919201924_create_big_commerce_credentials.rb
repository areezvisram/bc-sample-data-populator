class CreateBigCommerceCredentials < ActiveRecord::Migration[7.1]
  def change
    create_table :big_commerce_credentials do |t|
      t.string :access_token
      t.string :store_hash
      t.string :store_owner

      t.timestamps
    end
  end
end
