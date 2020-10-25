class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string      :charge_id, null: false
      t.references  :user,      foreign_key: true
      t.references  :item,      foreign_key: true
      t.integer     :quantity,  null: false

      t.timestamps
    end
  end
end
