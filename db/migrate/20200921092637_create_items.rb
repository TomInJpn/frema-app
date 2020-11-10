class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.references  :user,                  foreign_key: true
      t.references  :category,              foreign_key: true
      t.string      :name,                  null: false, default: "", limit:40
      t.text        :description,           null: false,              limit:1000
      t.string      :brand,                              default: ""
      t.integer     :condition_id,          null: false, default: nil
      t.integer     :shipment_fee_id,       null: false, default: nil
      t.integer     :prefecture_id,         null: false, default: nil
      t.integer     :shipment_schedule_id,  null: false, default: nil
      t.integer     :stock,                 null: false, default: nil
      t.integer     :price,                 null: false, default: nil

      t.timestamps
    end
  end
end
