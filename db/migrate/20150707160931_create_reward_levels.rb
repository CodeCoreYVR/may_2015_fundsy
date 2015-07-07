class CreateRewardLevels < ActiveRecord::Migration
  def change
    create_table :reward_levels do |t|
      t.string :title
      t.text :description
      t.integer :amount
      t.references :campaign, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
