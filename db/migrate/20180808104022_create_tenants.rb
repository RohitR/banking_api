class CreateTenants < ActiveRecord::Migration[5.2]
  def change
    create_table :tenants do |t|
      t.string :subdomain
      t.integer :port_number
      t.string :api_key

      t.timestamps
    end
  end
end
