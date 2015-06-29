class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.text :description
      t.integer :goal
      t.datetime :due_date

      t.timestamps null: false
    end
  end
end
