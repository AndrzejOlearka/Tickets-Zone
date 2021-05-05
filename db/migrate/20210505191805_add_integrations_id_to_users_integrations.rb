class AddIntegrationsIdToUsersIntegrations < ActiveRecord::Migration[6.1]
  def change
    add_column :users_integrations, :integration_id, :integer
    add_index :users_integrations, :integration_id
  end
end
