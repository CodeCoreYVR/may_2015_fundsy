class AddCredentialsTokenSecretToUsers < ActiveRecord::Migration
  def change
    add_column :users, :credentials_token, :string
    add_column :users, :credentials_secret, :string
  end
end
