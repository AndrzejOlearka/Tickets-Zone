class AddUserIdToUsersIntegrations < ActiveRecord::Migration[6.1]
  def change
    add_column :users_integrations, :user_id, :integer
    add_index :users_integrations, :user_id
  end
end
