class CreateAddresses < ActiveRecord::Migration[6.0]
  def change
    create_table :addresses do |t|
      t.string :phone_number, null: false, default: ""
      t.string :postal_code, default: ""
      t.integer :prefecture_id, default: 0
      t.string :city, default: ""
      t.string :house_number, default: ""
      t.string :building_name, default: ""
      t.references :user, foreign_key: true
      t.timestamps
    end
  end
end
