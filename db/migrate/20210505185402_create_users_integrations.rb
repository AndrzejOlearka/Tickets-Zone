class CreateUsersIntegrations < ActiveRecord::Migration[6.1]
  def change
    create_table :users_integrations do |t|
      t.string :name
      t.string :uri
      t.string :username
      t.text :password
      t.text :options

      t.timestamps
    end
  end
end
