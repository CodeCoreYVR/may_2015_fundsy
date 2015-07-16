class AddPaymentAndStateFieldsToPledges < ActiveRecord::Migration
  def change
    add_column :pledges, :stripe_txn_id, :string
    add_column :pledges, :aasm_state, :string
  end
end
