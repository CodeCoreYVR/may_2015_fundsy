class AddStripeFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :stripe_customer_token, :string
    add_column :users, :stripe_last_4, :string
    add_column :users, :stripe_card_type, :string
  end
end
