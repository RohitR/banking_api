class CreateBankRegistrations < ActiveRecord::Migration[5.2]
  def change
    create_table :bank_registrations do |t|
      t.string :type
      t.jsonb :details, default: {}
      t.integer :status, default: 0

      t.timestamps
    end
  end
end
