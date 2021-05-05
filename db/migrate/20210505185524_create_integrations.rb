class CreateIntegrations < ActiveRecord::Migration[6.1]
  def change
    create_table :integrations do |t|
      t.string :name

      t.timestamps
    end
  end
end
