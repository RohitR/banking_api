class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string :urn
      t.jsonb :detials, default: {}
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
