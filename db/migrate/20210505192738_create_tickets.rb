class CreateTickets < ActiveRecord::Migration[6.1]
  def change
    create_table :tickets do |t|
      t.integer :user_id
      t.integer :user_integration_id
      t.integer :unique_id
      t.string :subject
      t.string :department
      t.string :priority
      t.datetime :created
      t.index ["user_id"], name: "index_tickets_on_user_id"
      t.index ["integration_id"], name: "index_tickets_on_user_integration_id"
      t.timestamps
    end
  end
end
