class CreateLikes < ActiveRecord::Migration[6.0]
  def change
    create_table :likes do |t|
      t.references :item, forign_key: true
      t.references :user, forign_key: true
      t.timestamps
    end
  end
end
