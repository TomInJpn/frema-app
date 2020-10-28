class CreatePayments < ActiveRecord::Migration[5.2]
  def change
    create_table :payments do |t|
      t.string      :charge_id, null: false
      t.references  :user,      foreign_key: true
      t.references  :buyer,     foreign_key: {to_table: :users}
      t.integer     :item_id,   null: false
      t.integer     :quantity,  null: false
      t.integer     :payment,   null: false

      t.timestamps
    end
  end
end
